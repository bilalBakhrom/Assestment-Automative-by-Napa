//
//  ImageTextButtonNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation
import AsyncDisplayKit

final public class ImageTextButtonNode: BaseNode {
    private let iconName: String
    private let title: String
    private var onClick: ((ImageTextButtonNode) -> Void)?
    public var tag: Int = 0
    
    private lazy var containerNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .Theme.secondaryBackground
        node.cornerRadius = 10
        
        return node
    }()
    
    private lazy var iconNode: ASImageNode = {
        let node = ASImageNode()
        node.tintColor = .Theme.accent
        node.image = UIImage(named: iconName)
        node.style.preferredSize = .init(width: 20, height: 20)
        
        return node
    }()
    
    private lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = attributedText(title)
        
        return node
    }()
    
    private lazy var buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        
        return node
    }()
    
    public init(iconName: String, title: String, action: ((ImageTextButtonNode) -> Void)? = nil) {
        self.iconName = iconName
        self.title = title
        self.onClick = action
    }
    
    @objc private func handleClick() {
        onClick?(self)
    }
    
    private func attributedText(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Theme.accent,
            .font: UIFont.systemFont(ofSize: 10, weight: .regular)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}

// MARK: - Layout
extension ImageTextButtonNode {
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let containerSpec = ASInsetLayoutSpec(
            insets: .zero,
            child: containerNode)
        
        let iconAndTitleVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .center,
            alignItems: .center,
            children: [iconNode, titleNode])
        
        let overlay = ASOverlayLayoutSpec(child: containerSpec, overlay: iconAndTitleVStack)
        
        return overlay
    }
}
