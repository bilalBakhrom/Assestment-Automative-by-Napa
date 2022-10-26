//
//  CallsControllerNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit
import TelegramNetwork

public class CallsControllerNode: BaseNode {
    private var dataSource: CallsTableDataSource!
    private var openInfo: (Call) -> Void
    
    private lazy var tableNode: ASTableNode = {
        let node = ASTableNode(style: .plain)
        node.allowsSelection = true
        node.backgroundColor = .Theme.primaryBackground
        
        return node
    }()
    
    public init(openInfo: @escaping (Call) -> Void) {
        self.openInfo = openInfo
        super.init()
        
        dataSource = CallsTableDataSource(interaction: CallsNodeInteraction(openInfo: openInfo))
        tableNode.dataSource = dataSource
        
        dataSource.reload = { [weak self] in
            DispatchQueue.main.async { self?.tableNode.reloadData() }
        }
        
        dataSource.fetchCalls()
    }
    
    func filter(by segment: CallSegment) {
        dataSource.filter(by: segment)
        tableNode.reloadData()
    }
    
    func setEditing(_ editing: Bool) {
        dataSource.editing = editing
        tableNode.reloadData()
    }
}

// MARK: - ASTableDelegate
extension CallsControllerNode: ASTableDelegate {
    public func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeMake(CGSize(width: UIScreen.main.bounds.width, height: 44))
    }
}

// MARK: - Layout
extension CallsControllerNode {
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: tableNode)
    }
}
