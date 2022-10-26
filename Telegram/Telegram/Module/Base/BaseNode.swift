//
//  BaseNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit

public class BaseNode: ASDisplayNode {
    override public init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
}
