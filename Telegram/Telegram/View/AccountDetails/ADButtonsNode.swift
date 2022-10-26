//
//  ADButtonsNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit

fileprivate struct Constants {
    static let cornerRadius: CGFloat = 10
    static let spacing: CGFloat = 10
    static var itemSize: CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let margin: CGFloat = 12
        let width = (screenWidth - (margin * 2) - (spacing * 4)) / 5
        
        return CGSize(width: width, height: 52)
    }
}

final class ADButtonsNode: BaseNode {
    private var buttons: [ImageTextButtonNode] = []
    
    public override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        let types = ADButtonType.allCases
        let preferredSize = Constants.itemSize
        
        buttons = types.map { type in
            let node = ImageTextButtonNode(
                iconName: type.iconName,
                title: type.title,
                action: { [weak self] sender in self?.handleButtonClick(sender)})
            node.cornerRadius = Constants.cornerRadius
            node.style.preferredSize = preferredSize
            node.tag = type.rawValue
            
            return node
        }
    }
    
    private func handleButtonClick(_ sender: ImageTextButtonNode) {
        
    }
}

// MARK: - Layout
extension ADButtonsNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: Constants.spacing,
            justifyContent: .start,
            alignItems: .end,
            children: buttons)
        
        return hStack
    }
}
