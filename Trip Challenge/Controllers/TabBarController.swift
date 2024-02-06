//
//  TabBarController.swift
//  Trip Challenge
//
//  Created by Kate on 03/02/2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize view controllers
        let mainVC = MainVC()
        let mapVC = MapVC()
        let promoVC = PromoVC()
        let profileTVC = ProfileTVC()

        // Set tab bar items
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
        promoVC.tabBarItem = UITabBarItem(title: "Promo", image: UIImage(systemName: "percent"), tag: 2)
        profileTVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)

        // Wrap each view controller in a navigation controller
        let controllers = [mainVC, mapVC, promoVC, profileTVC].map { UINavigationController(rootViewController: $0) }
        self.viewControllers = controllers

        // Optional: Customize tab bar appearance
        tabBar.backgroundColor = .white
    }
}
