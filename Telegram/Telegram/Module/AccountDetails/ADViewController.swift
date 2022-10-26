//
//  ADViewController.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit
import TelegramNetwork

public class ADViewController: BaseController {
    private var call: Call?
    
    private var controllerNode: ADControllerNode {
        displayNode as! ADControllerNode
    }
    
    public init(call: Call) {
        self.call = call
        super.init()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController as? BaseNavController)?.customizeNavigationBarForNewStyle(backgroundColor: .clear)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (navigationController as? BaseNavController)?.customizeNavigationBarForNewStyle()
    }
    
    public override func loadDisplayNode() {
        defer { call = nil }
        guard let call = call else { return }
                
        displayNode = ADControllerNode(call: call)
        displayNode.backgroundColor =  .Theme.secondaryBackground
    }
}
