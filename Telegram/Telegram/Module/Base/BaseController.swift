//
//  BaseController.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit

public class BaseController: ASDKViewController<BaseNode> {
    private var _displayNode: ASDisplayNode?
    
    public final var displayNode: ASDisplayNode {
        get {
            if let node = _displayNode {
                return node
            } else {
                loadDisplayNode()
                
                if _displayNode == nil {
                    fatalError("displayNode should be initialized after loadDisplayNode()")
                }
                
                return _displayNode!
            }
        }
        set(value) {
            self._displayNode = value
        }
    }
    
    public override init() {
        super.init(node: BaseNode())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = displayNode.view
    }
    
    open func loadDisplayNode() {
        self.displayNode = ASDisplayNode()
    }
}
