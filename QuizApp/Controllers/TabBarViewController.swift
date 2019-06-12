//
//  TabBarViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 11/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController()
        vc1.pushViewController(QuizzesListViewController(), animated: false)
        vc1.tabBarItem = UITabBarItem(title: "Quizzes", image: nil, tag: 0)
        
        let vc2 = SearchViewController()
        vc2.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 0)
        
        let vc3 = SettingsViewController()
        vc3.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 0)
        
        self.viewControllers = [vc1, vc2, vc3]
    }

}
