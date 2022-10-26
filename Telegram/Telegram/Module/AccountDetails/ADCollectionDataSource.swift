//
//  ADCollectionDataSource.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit
import TelegramNetwork

final class ADCollectionDataSource: NSObject, ASCollectionDataSource {
    private var callBlock: () -> Call?
    
    init(callBlock: @escaping () -> Call?) {
        self.callBlock = callBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let block = { () -> ASCellNode in
            return ASCellNode()
        }
        
        return block
    }
    
    func collectionNode(
        _ collectionNode: ASCollectionNode,
        nodeBlockForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> ASCellNodeBlock {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return { () -> ASCellNode in
                if let call = self.callBlock() {
                    let node = ADHeaderNode()
                    node.configure(with: call)
                    
                    return node
                } else {
                    return ASCellNode()
                }
            }
            
        default:
            return { ASCellNode() }
        }
    }
}
