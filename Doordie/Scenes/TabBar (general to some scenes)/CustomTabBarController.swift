//
//  CustomTabBarController.swift
//  Doordie
//
//  Created by Arseniy on 28.12.2024.
//

import Foundation
import UIKit

final class CustomTabBarController: UITabBarController {
    // MARK: - Constants
    private enum Constants {
        // homeTab
        static let homeTitle: String = "Home"
        static let homeImageName: String = "house.fill"
        
        // analyticsTab
        static let analyticsTitle: String = "Analytics"
        static let analyticsImageName: String = "chart.bar.fill"
        
        // dummyTab
        static let dummyTitle: String = ""
        
        // friendsTab
        static let friendsTitle: String = "Friends"
        static let friendImageName: String = "person.2.fill"
        
        // settingsTab
        static let settingsTitle: String = "Settings"
        static let settingsImageName: String = "gear"
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureTabBar()
        configureTabs()
    }
    
    private func configureTabBar() {
        // Заменяем стандартный tabBar на кастомный
        self.setValue(CustomTabBar(), forKey: "tabBar")
    }
    
    private func configureTabs() {
        // Создаём контроллеры
        
        // 1) Home
        let homeTabTitle = Constants.homeTitle
        let homeTabImage: UIImage? = UIImage(systemName: Constants.homeImageName)
        let homeTabVC: UIViewController = HomeAssembly.build()
        
        let homeTab = createTab(with: homeTabTitle, and: homeTabImage, vc: homeTabVC)
        
        // 2) Analytics
        let analyticsTabTitle: String = Constants.analyticsTitle
        let analyticsTabImage: UIImage? = UIImage(systemName: Constants.analyticsImageName)
        let analyticsTabVC: UIViewController = UIViewController()
        
        let analyticsTab = createTab(with: analyticsTabTitle, and: analyticsTabImage, vc: analyticsTabVC)
        
        // 3) Пустой контроллер под «плюс»-кнопку (фейковая вкладка)
        let plusDummyTabTitle: String = Constants.dummyTitle
        let plusDummyTabImage: UIImage? = nil
        let plusDummyTabVC = UIViewController()
        let plusDummyTab = createTab(with: plusDummyTabTitle, and: plusDummyTabImage, vc: plusDummyTabVC)
        
        // 4) Friends
        let friendTabTitle: String = Constants.friendsTitle
        let friendsTabImage: UIImage? = UIImage(systemName: Constants.friendImageName)
        let friendsTabVC: UIViewController = UIViewController()
        
        let friendsTab = createTab(with: friendTabTitle, and: friendsTabImage, vc: friendsTabVC)
        
        // 5) Settings
        let settingsTabTitle: String = Constants.settingsTitle
        let settingsTabImage: UIImage? = UIImage(systemName: Constants.settingsImageName)
        let settingsTabVC: UIViewController = UIViewController()
        
        let settingsTab = createTab(with: settingsTabTitle, and: settingsTabImage, vc: settingsTabVC)
        
        self.setViewControllers([
            homeTab,
            analyticsTab,
            plusDummyTab,
            friendsTab,
            settingsTab
        ], animated: true)
    }
    
    private func createTab(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let tab = UINavigationController(rootViewController: vc)
        tab.tabBarItem.title = title
        tab.tabBarItem.image = image
        
        return tab
    }
}
