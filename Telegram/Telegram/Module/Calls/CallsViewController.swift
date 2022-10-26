//
//  CallsViewController.swift
//  Telegram
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import AsyncDisplayKit

public class CallsViewController: BaseController {
    private var controllerNode: CallsControllerNode {
        displayNode as! CallsControllerNode
    }
    
    private lazy var callsSegmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: CallSegment.allCases.map(\.title))
        view.backgroundColor = .Theme.primaryBackground
        view.tintColor = .Theme.secondaryBackground
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        return view
    }()
    
    private lazy var callButtonItem: UIBarButtonItem = {
        UIBarButtonItem(
            image: UIImage(named: "icon.add.call"),
            style: .plain,
            target: self,
            action: #selector(handleSegmentChange)
        )
    }()
    
    public override func loadDisplayNode() {
        displayNode = CallsControllerNode(openInfo: { [weak self] call in
            // TODO: Open account details
        })
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.titleView = callsSegmentedControl
        navigationItem.rightBarButtonItem = callButtonItem
    }
    
    public override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        controllerNode.setEditing(editing)
        
        if editing {
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = callButtonItem
        }
    }
    
    // MARK: - Action
    @objc private func handleSegmentChange() {
        guard let segment = CallSegment(rawValue: callsSegmentedControl.selectedSegmentIndex) else {
            return
        }
        
        controllerNode.filter(by: segment)
    }
    
    @objc private func handleOutgoingCall() {
        // TODO: - Display outgoind call controller
    }
}
