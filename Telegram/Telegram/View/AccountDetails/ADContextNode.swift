//
//  ADContextNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit
import TelegramNetwork

fileprivate struct Constants {
    static let profileImageSize: CGFloat = 90
}

final class ADContextNode: BaseNode {
    private lazy var profileImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.backgroundColor = .gray
        node.cornerRadius = Constants.profileImageSize / 2
        node.style.preferredSize = CGSize(
            width: Constants.profileImageSize,
            height: Constants.profileImageSize)
        
        return node
    }()
    
    private var nameNode = ASTextNode()
    private var seenNode = ASTextNode()
    
    override init() {
        super.init()
        
        backgroundColor = .clear
    }
    
    func configure(with call: Call) {
        // Load image.
        if let imagePath = call.user.profileImageURL {
            profileImageNode.url = URL(string: imagePath)
        } else {
            profileImageNode.url = nil
        }
        // Update full name.
        let fullName = [call.user.firstName, call.user.lastName]
            .compactMap { $0 }
            .joined(separator: " ")
        nameNode.attributedText = formatPrimaryText(fullName)
        // Update last seen.
        seenNode.attributedText = formatSecodaryText("last seen recently")
    }
    
    private func formatPrimaryText(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Theme.primaryLabel,
            .font: UIFont.systemFont(ofSize: 28, weight: .regular)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    private func formatSecodaryText(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Theme.primaryLabel.withAlphaComponent(0.4),
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}

// MARK: - Layout
extension ADContextNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nameAndSeenVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .center,
            children: [nameNode, seenNode])
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .start,
            alignItems: .center,
            children: [profileImageNode, nameAndSeenVStack])
    }
}
