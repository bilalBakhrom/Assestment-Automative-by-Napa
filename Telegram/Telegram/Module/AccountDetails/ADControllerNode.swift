//
//  ADControllerNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit
import TelegramNetwork

final class ADControllerNode: BaseNode {
    private var call: Call
    private var dataSource: ADCollectionDataSource!
    
    private lazy var collectionNode: ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = ASCollectionNode(collectionViewLayout: layout)
        collection.backgroundColor = .Theme.primaryBackground
        collection.delegate = self
        collection.dataSource = dataSource
        collection.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
        
        return collection
    }()
    
    init(call: Call) {
        self.call = call
        super.init()
        
        dataSource = ADCollectionDataSource(
            callBlock: { [weak self] in
                return self?.call
            }
        )
    }
}

extension ADControllerNode: ASCollectionDelegate {}

extension ADControllerNode: ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        ASSizeRangeUnconstrained
    }
}

// MARK: - Layout
extension ADControllerNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASInsetLayoutSpec(insets: .zero, child: collectionNode)
    }
}
