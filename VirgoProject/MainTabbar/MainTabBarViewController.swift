//
//  MainTabBarViewController.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TMDB"
        
        UITabBar.appearance().barTintColor = UIColor(named: "tertiary_color")
        tabBar.tintColor = UIColor.white
        setuViewControllers()
    }
    
    func setuViewControllers() {
        let firstViewController = getTabBar(viewController: TmdbRootViewController(), image: UIImage(named: "icon_home"), tag: 0)
        let secondViewController = getTabBar(viewController: AccountViewController(), image: UIImage(named: "icon_account"), tag: 0)
        
        viewControllers = [firstViewController, secondViewController]
    }
    
    func getTabBar(viewController: UIViewController,
                             image: UIImage?,
                             tag: Int) -> UIViewController {
        let vc = viewController
        vc.tabBarItem.image = image?.withRenderingMode(.alwaysTemplate)
        vc.tabBarItem.tag = tag
        
        return vc
    }

}
