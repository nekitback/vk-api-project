//
//  MainTabBarViewController.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 10.09.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    var friendsViewController: FriendsViewController = {
        let friendsVC = FriendsViewController()
        let friendsTabBarItem = UITabBarItem()
        friendsTabBarItem.image = UIImage(systemName: "person.2")
        friendsTabBarItem.title = "Друзья"
        friendsVC.tabBarItem = friendsTabBarItem
        return friendsVC
    }()
    
    var groupsViewController: CommunitiesViewController = {
        let groupsVC = CommunitiesViewController()
        let groupsTabBarItem = UITabBarItem()
        groupsTabBarItem.image = UIImage(systemName: "person.3")
        groupsTabBarItem.title = "Группы"
        groupsVC.tabBarItem = groupsTabBarItem
        return groupsVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllers: [UIViewController] = [friendsViewController, groupsViewController]
        self.viewControllers = controllers
    }
    
}
