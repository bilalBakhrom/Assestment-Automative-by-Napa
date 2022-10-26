//
//  CallCellNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit
import TelegramNetwork

fileprivate struct Const {
    static let iconSize: CGFloat = 16
    static let profileImageSize: CGFloat = 36
    static let buttonSize: CGFloat = 20
    
    static let profileImageInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    static let contentInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 14)
}

final public class CallCellNode: BaseCellNode {
    private let nameNode = ASTextNode()
    private let statusNode = ASTextNode()
    private let dateNode = ASTextNode()
    private var editing: Bool = false
    private var item: Call!
    private var openInfo: (Call) -> Void
    private var onDelete: (Call) -> Void
    
    private lazy var deleteButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "icon.minus.fill"), for: .normal)
        node.style.preferredSize = CGSize(
            width: Const.buttonSize,
            height: Const.buttonSize)
        node.addTarget(self, action: #selector(handleDeleteButtonClick), forControlEvents: .touchUpInside)
        
        return node
    }()
    
    private lazy var iconNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(
            width: Const.iconSize,
            height: Const.iconSize)
        
        return node
    }()
    
    private lazy var profileImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.backgroundColor = .gray
        node.cornerRadius = Const.profileImageSize / 2
        node.style.preferredSize = CGSize(
            width: Const.profileImageSize,
            height: Const.profileImageSize)
        
        return node
    }()
    
    private lazy var infoButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "icon.info"), for: .normal)
        node.style.preferredSize = CGSize(width: Const.buttonSize, height: Const.buttonSize)
        node.addTarget(self, action: #selector(handleInfoButtonClick), forControlEvents: .touchUpInside)
        
        return node
    }()
    
    public init(openInfo: @escaping (Call) -> Void, onDelete: @escaping (Call) -> Void) {
        self.openInfo = openInfo
        self.onDelete = onDelete
        super.init()                
    }
}

// MARK: - Setup
extension CallCellNode {
    public func configure(with call: Call, editing: Bool = false) {
        self.item = call
        self.editing = editing
        
        setStatus(call)
        setImage(call.user.profileImageURL)
        setName(call.user, missed: isMissed(call: call))
        setDate(call.date)
    }
    
    private func setStatus(_ call: Call) {
        switch call.type {
        case .incoming:
            iconNode.image = nil
            
            if let incomingStatus = call.incomingStatus {
                switch incomingStatus {
                case .accepted:
                    statusNode.attributedText = makeSecodaryText("Incoming \(formatDuration(call.duration))")
                    
                case .rejected, .missed:
                    statusNode.attributedText = makeSecodaryText("Missed")
                }
            }
            
        case .outgoing:
            setIcon(call.connection)
            statusNode.attributedText = makeSecodaryText("Outgoing \(formatDuration(call.duration))")
        }
    }
    
    private func setImage(_ profileImageURL: String?) {
        if let imagePath = profileImageURL {
            profileImageNode.url = URL(string: imagePath)
        } else {
            profileImageNode.url = nil
        }
    }
    
    private func setName(_ user: User, missed: Bool) {
        let fullName = [user.firstName, user.lastName].compactMap { $0 }.joined(separator: " ")
        nameNode.attributedText = makePrimaryText(fullName, color: makeColorForName(missed: missed))
    }
    
    private func setDate(_ date: String) {
        let iDateFormatter = DateFormatFactory.shared.iDateFormatter
        let oDateFormatter = DateFormatFactory.shared.oDateFormatter
        let weeklyDateFormatter = DateFormatFactory.shared.weekDateFormatter
        
        if let date = iDateFormatter.date(from: date) {
            let thisWeek = Calendar.current.isDateInThisWeek(date)
            let formattedDate = thisWeek ? weeklyDateFormatter.string(from: date) : oDateFormatter.string(from: date)
            dateNode.attributedText = makeSecodaryText(formattedDate)
        } else {
            dateNode.attributedText = nil
        }
    }
}


// MARK: - Actions
extension CallCellNode {
    @objc private func handleDeleteButtonClick() {
        onDelete(item)
    }
    
    @objc private func handleInfoButtonClick() {
        openInfo(item)
    }
}

// MARK: - Support
extension CallCellNode {
    private func isMissed(call: Call) -> Bool {
        if let status = call.incomingStatus, case .incoming = call.type {
            return status != .accepted
        } else {
            return false
        }
    }
    
    private func setIcon(_ connection: CallConnection) {
        iconNode.image = item.connection == .audio
        ? UIImage(named: "icon.outgoing.audio")
        : UIImage(named: "icon.outgoing.video")
    }
    
    private func makeColorForName(missed: Bool) -> UIColor {
        missed ? .Theme.red : .Theme.primaryLabel
    }
    
    private func makePrimaryText(_ text: String, color: UIColor = UIColor.Theme.secondaryLabel) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        
        return NSAttributedString(
            string: text,
            attributes: attributes)
    }
    
    private func makeSecodaryText(_ text: String, color: UIColor = UIColor.Theme.secondaryLabel) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        
        return NSAttributedString(
            string: text,
            attributes: attributes)
    }
    
    private func formatDuration(_ duration: Int?) -> String {
        guard let duration = duration else { return "" }
        
        if duration < 60 {
            return "(\(duration) sec)"
        } else {
            return String(format: "(%d min)", duration / 60)
        }
    }
}

// MARK: - Layout
extension CallCellNode {
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let leadingHStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: editing ? [deleteButtonNode, iconNode] : [iconNode])
        
        let profileImageSpec = ASInsetLayoutSpec(
            insets: Const.profileImageInsets,
            child: profileImageNode)

        let nameAndStatusVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .notSet,
            children: [nameNode, statusNode])
        nameAndStatusVStack.style.flexGrow = 1
        
        let dateAndInfoHStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .end,
            alignItems: .center,
            children: editing ? [dateNode] : [dateNode, infoButtonNode])
        
        let finalStack =  ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10,
            justifyContent: .start,
            alignItems: .center,
            children: [leadingHStack, profileImageSpec, nameAndStatusVStack, dateAndInfoHStack])
        
        return ASInsetLayoutSpec(insets: Const.contentInsets, child: finalStack)
    }
}
