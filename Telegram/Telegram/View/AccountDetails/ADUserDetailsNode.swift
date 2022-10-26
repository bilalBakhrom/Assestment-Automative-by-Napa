//
//  ADUserDetailsNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit

final class ADUserDetailsNode: BaseNode {
    private var nodes: [ASDisplayNode] = []
    
    override init() {
        super.init()
        backgroundColor = .Theme.secondaryBackground
    }
    
    func configure() {
        let infos: [UserDetail] = [
            UserDetail(type: .mobile, name: "mobile", data: "+447796497604"),
            UserDetail(type: .username, name: "username", data: "@onepiece"),
            UserDetail(type: .bio, name: "bio", data: "iOS Developer"),
        ]
        
        nodes = infos.map { info in
            switch info.type {
            case .mobile:
                return TitleSubtitleNode(title: info.name, subtitle: info.data, isLink: true)
            case .username:
                return TitleSubtitleNode(title: info.name, subtitle: info.data, isLink: true)
            case .bio:
                return TitleSubtitleNode(title: info.name, subtitle: info.data, isLink: false)
            }
        }
    }
    
    private func makeSeparatorLayoutSpec() -> ASLayoutSpec {
        let node = ASDisplayNode()
        node.backgroundColor = .white.withAlphaComponent(0.1)
        node.style.height = ASDimensionMake(.points, 0.5)
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0),
            child: node)
    }
    
    private func wrapWithLayoutSpec(_ node: ASDisplayNode) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12),
            child: node)
    }
}

// MARK: - Layout
extension ADUserDetailsNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var stackNodes: [ASLayoutSpec] = []
        
        (0..<nodes.count).forEach { index in
            stackNodes.append(wrapWithLayoutSpec(nodes[index]))
            
            if index != nodes.count - 1 {
                stackNodes.append(makeSeparatorLayoutSpec())
            }
        }
        
        let vStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .center,
            alignItems: .start,
            children: stackNodes)
        
        let contentLayout = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0),
            child: vStack)
        
        return contentLayout
    }
}
