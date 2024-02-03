//
//  TabBarController.swift
//  Trip Challenge
//
//  Created by Kate on 03/02/2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainVC = MainVC()
        let mapVC = MapVC()
        let promoVC = PromoVC()
        let profileTVC = ProfileTVC()

        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 0)
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "mapIcon"), tag: 1)
        promoVC.tabBarItem = UITabBarItem(title: "Promo", image: UIImage(named: "promoIcon"), tag: 2)
        profileTVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileIcon"), tag: 3)

        let controllers = [mainVC, mapVC, promoVC, profileTVC].map { UINavigationController(rootViewController: $0) }
        self.viewControllers = controllers
    }
}
