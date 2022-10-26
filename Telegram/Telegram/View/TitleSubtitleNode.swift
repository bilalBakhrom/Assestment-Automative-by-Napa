//
//  TitleSubtitleNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit

final public class TitleSubtitleNode: BaseNode {
    public var tag: Int = 0
    private let title: String
    private let subtitle: String
    private let isLink: Bool
    private var action: (() -> Void)?
    
    private lazy var titleNode: ASTextNode = {
        let textNode = ASTextNode()
        textNode.attributedText = titleAttributedText(title)
        textNode.style.alignSelf = .start
        
        return textNode
    }()
    
    private lazy var subtitleNode: ASTextNode = {
        let textNode = ASTextNode()
        textNode.attributedText = isLink ? linkAttributedText(subtitle) : titleAttributedText(subtitle)
        textNode.style.alignSelf = .start
        
        return textNode
    }()
    
    public init(title: String, subtitle: String, isLink: Bool, action: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.isLink = isLink
        self.action = action
    }
    
    private func titleAttributedText(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Theme.primaryLabel,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    private func linkAttributedText(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Theme.accent,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}

// MARK: - Layout
extension TitleSubtitleNode {
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let titleLinkStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 2,
            justifyContent: .center,
            alignItems: .start,
            children: [titleNode, subtitleNode])
        
        let contentLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10,
            justifyContent: .center,
            alignItems: .start,
            children: [titleLinkStack])
        contentLayout.style.flexGrow = 1
        
        return contentLayout
    }
}
