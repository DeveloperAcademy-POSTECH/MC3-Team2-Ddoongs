//
//  TabViewController.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/19.
//

import UIKit

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabItems()
    }
    
    fileprivate func setTabItems() {
        let myBoardViewController = UINavigationController.init(rootViewController: CategoryListViewController())
        
        let KPopSlangViewController = UINavigationController.init(rootViewController: DictionaryViewController())
        self.viewControllers = [myBoardViewController, KPopSlangViewController]
        
        let myBoardTabBarItem = UITabBarItem(title: "My Board", image: UIImage(systemName: "keyboard"), tag: 0)
        let KPopSlangTabBarItem = UITabBarItem(title: "K-pop Slang", image: UIImage(systemName: "book.closed"), tag: 1)
        
        myBoardViewController.tabBarItem = myBoardTabBarItem
        KPopSlangViewController.tabBarItem = KPopSlangTabBarItem
    }
    
}
