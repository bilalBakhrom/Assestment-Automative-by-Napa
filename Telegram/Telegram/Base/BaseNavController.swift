//
//  BaseNavController.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import UIKit

public class BaseNavController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBarForNewStyle()
    }
    
    public func customizeNavigationBarForNewStyle(backgroundColor: UIColor = UIColor.Theme.secondaryBackground) {
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.configureWithOpaqueBackground()
            barAppearance.backgroundColor = backgroundColor
            barAppearance.shadowColor = .clear
            barAppearance.shadowImage = UIImage()
            
            navigationBar.standardAppearance = barAppearance
            navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            UIApplication.shared.statusBarView?.backgroundColor = backgroundColor
            navigationBar.backgroundColor = backgroundColor
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
}

fileprivate extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
