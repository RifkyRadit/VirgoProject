//
//  AppDelegate.swift
//  VirgoProject
//
//  Created by Administrator on 21/05/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.backgroundColor = .white
        let viewController = UINavigationController(rootViewController: MainTabBarViewController())
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

