//
//  ADHeaderNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation
import AsyncDisplayKit
import TelegramNetwork

final class ADHeaderNode: BaseCellNode {
    private var accounContext = ADContextNode()
    private var actionsNode = ADButtonsNode()
    private var callLogNode = ADCallLogsNode()
    private var userDetails = ADUserDetailsNode()
    
    override init() {
        super.init()
        
        backgroundColor = .clear
        selectionStyle = .none
        userDetails.cornerRadius = 10
    }
    
    func configure(with call: Call) {
        // Load image and name.
        accounContext.configure(with: call)
        // Update logs.
        callLogNode.configure(with: WTimeService(), call: call)
        // Update user details.
        userDetails.configure()
    }
}

// MARK: - Layout
extension ADHeaderNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let actionsSpec = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0),
            child: actionsNode
        )
        
        let contentSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .start,
            alignItems: .stretch,
            children: [accounContext, actionsSpec, callLogNode, userDetails])
        
        let spec = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12),
            child: contentSpec)
        spec.style.flexGrow = 1
        
        return spec
    }
}
