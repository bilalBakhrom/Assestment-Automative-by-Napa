//
//  BaseCellNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit

public class BaseCellNode: ASCellNode {
    public override init() {
        super.init()
        
        backgroundColor = .clear
        selectionStyle = .none
        automaticallyManagesSubnodes = true
    }
}
