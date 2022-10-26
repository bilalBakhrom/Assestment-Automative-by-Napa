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

final class CallCellNode: BaseCellNode {
    private let nameNode = ASTextNode()
    private let statusNode = ASTextNode()
    private let dateNode = ASTextNode()
    private var editing: Bool = false
    private var item: Call!
    private var openInfo: (Call) -> Void
    private var onDelete: (Call) -> Void
    
    lazy var deleteButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "icon.minus.fill"), for: .normal)
        node.style.preferredSize = CGSize(
            width: Const.buttonSize,
            height: Const.buttonSize)
        node.addTarget(self, action: #selector(handleDeleteButtonClick), forControlEvents: .touchUpInside)
        
        return node
    }()
    
    lazy var iconNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(
            width: Const.iconSize,
            height: Const.iconSize)
        
        return node
    }()
    
    lazy var profileImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.backgroundColor = .gray
        node.cornerRadius = Const.profileImageSize / 2
        node.style.preferredSize = CGSize(
            width: Const.profileImageSize,
            height: Const.profileImageSize)
        
        return node
    }()
    
    lazy var infoButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "icon.info"), for: .normal)
        node.style.preferredSize = CGSize(
            width: Const.buttonSize,
            height: Const.buttonSize)
        node.addTarget(self, action: #selector(handleInfoButtonClick), forControlEvents: .touchUpInside)
        
        return node
    }()
    
    init(openInfo: @escaping (Call) -> Void, onDelete: @escaping (Call) -> Void) {
        self.openInfo = openInfo
        self.onDelete = onDelete
        super.init()
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(with item: Call, editing: Bool = false) {
        self.item = item
        self.editing = editing
        var hasMissed: Bool = false
        // Update status.
        switch item.type {
        case .incoming:
            iconNode.image = nil
            if let incomingStatus = item.incomingStatus {
                switch incomingStatus {
                case .accepted:
                    statusNode.attributedText = formatSecodaryText("Incoming \(formatDuration(item.duration))")
                    
                case .rejected, .missed:
                    statusNode.attributedText = formatSecodaryText("Missed")
                    hasMissed = true
                }
            }
            
        case .outgoing:
            iconNode.image = item.connection == .audio ? UIImage(named: "icon.outgoing.audio") : UIImage(named: "icon.outgoing.video")
            statusNode.attributedText = formatSecodaryText("Outgoing \(formatDuration(item.duration))")
        }
        // Load image.
        if let imagePath = item.user.profileImageURL {
            profileImageNode.url = URL(string: imagePath)
        } else {
            profileImageNode.url = nil
        }
        // Update full name.
        let fullName = [item.user.firstName, item.user.lastName].compactMap { $0 }.joined(separator: " ")
        nameNode.attributedText = formatPrimaryText(
            fullName,
            color: hasMissed ? .Theme.red : .Theme.primaryLabel)
        // Update date.
        let iDateFormatter = DateFormatFactory.shared.iDateFormatter
        let oDateFormatter = DateFormatFactory.shared.oDateFormatter
        let weeklyDateFormatter = DateFormatFactory.shared.weekDateFormatter
        
        if let date = iDateFormatter.date(from: item.date) {
            let thisWeek = Calendar.current.isDateInThisWeek(date)
            let formattedDate = thisWeek ? weeklyDateFormatter.string(from: date) : oDateFormatter.string(from: date)
            dateNode.attributedText = formatSecodaryText(formattedDate)
        } else {
            dateNode.attributedText = nil
        }
    }
    
    // MARK: - Actions
    @objc private func handleDeleteButtonClick() {
        onDelete(item)
    }
    
    @objc private func handleInfoButtonClick() {
        openInfo(item)
    }
    
    // MARK: - Support
    private func formatPrimaryText(_ text: String, color: UIColor = UIColor.Theme.secondaryLabel) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        
        return NSAttributedString(
            string: text,
            attributes: attributes)
    }
    
    private func formatSecodaryText(_ text: String, color: UIColor = UIColor.Theme.secondaryLabel) -> NSAttributedString {
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
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
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
