//
//  AppDelegate.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            // Starts from SceneDelegate.
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            
            let viewController = CallsViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

