//
//  TabController.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

final class TabController: UITabBarController {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let tabBarBackgroungColorHexCode: String = "4C60C2"
        static let tabBarBackgroundColor: UIColor = UIColor(hex: tabBarBackgroungColorHexCode)
        static let tabBarTintColor: UIColor = .white
        static let tabBarUnselectedTintColor: UIColor = .white.withAlphaComponent(0.3)
        static let navBarBackgroundColor: UIColor = .darkGray.withAlphaComponent(0.95)
        static let navBarTitleColor: UIColor = .white
        
        // home view
        static let homeTitle: String = "Home"
        static let homeImageName: String = "house.fill"
        
        // analytics view
        static let analyticsTitle: String = "Analytics"
        static let analyticsImageName: String = "chart.pie.fill"
        
        // friends view
        static let friendsTitle: String = "Friends"
        static let friendImageName: String = "person.2.fill"
        
        // settings view
        static let settingsTitle: String = "Settings"
        static let settingsImageName: String = "gear"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
        configureUI()
    }
    
    // MARK: - Tab Setup
    private func configureTabs() {
        let home = self.createNav(with: Constants.homeTitle, and: UIImage(systemName: Constants.homeImageName), vc: HomeAssembly.build())
        let analytics = self.createNav(with: Constants.analyticsTitle, and: UIImage(systemName: Constants.analyticsImageName), vc: UIViewController())
        let friends = self.createNav(with: Constants.friendsTitle, and: UIImage(systemName: Constants.friendImageName), vc: UIViewController())
        let settings = self.createNav(with: Constants.settingsTitle, and: UIImage(systemName: Constants.settingsImageName), vc: UIViewController())
        
        self.setViewControllers([home, analytics, friends, settings], animated: true)
    }
    
    private func configureUI() {
        self.tabBar.backgroundColor = Constants.tabBarBackgroundColor
        self.tabBar.tintColor = Constants.tabBarTintColor
        self.tabBar.unselectedItemTintColor = Constants.tabBarUnselectedTintColor
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}
