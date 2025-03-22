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
        enum HomeTab {
            static let title: String = "Home"
            static let imageName: String = "house.fill"
            static let tag: Int = 0
        }
        
        enum AnalyticsTab {
            static let title: String = "Analytics"
            static let imageName: String = "chart.bar.fill"
            static let tag: Int = 1
        }
        
        enum DummyTab {
            static let title: String = ""
        }
        
        enum FriendsTab {
            static let title: String = "Friends"
            static let imageName: String = "person.2.fill"
            static let tag: Int = 2
        }
        
        enum SettingsTab {
            static let title: String = "Settings"
            static let imageName: String = "gear"
            static let tag: Int = 3
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = .clear
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureTabBar()
        configureTabs()
    }
    
    private func configureTabBar() {
        // Заменяем стандартный tabBar на кастомный
        let customTabBar = CustomTabBar()
        customTabBar.tabBarController = self
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    private func configureTabs() {
        // Создаём контроллеры
        
        // 1) Home
        let homeTabTitle = Constants.HomeTab.title
        let homeTabImage: UIImage? = UIImage(systemName: Constants.HomeTab.imageName)
        let homeTabVC: UIViewController = HomeAssembly.build()
        let homeTabTag: Int = Constants.HomeTab.tag
        
        let homeTab = createTab(title: homeTabTitle, image: homeTabImage, tag: homeTabTag, vc: homeTabVC)
        
        // 2) Analytics
        let analyticsTabTitle: String = Constants.AnalyticsTab.title
        let analyticsTabImage: UIImage? = UIImage(systemName: Constants.AnalyticsTab.imageName)
        let analyticsTabVC: UIViewController = AnalyticsAssembly.build()
        let analyticsTabTag: Int = Constants.AnalyticsTab.tag
        
        let analyticsTab = createTab(title: analyticsTabTitle, image: analyticsTabImage, tag: analyticsTabTag, vc: analyticsTabVC)
        
        // 3) Пустой контроллер под «плюс»-кнопку (фейковая вкладка)
        let plusDummyTabTitle: String = Constants.DummyTab.title
        let plusDummyTabImage: UIImage? = nil
        let plusDummyTabVC = AddHabitAssembly.build()
        let plusDummyTab = createTab(title: plusDummyTabTitle, image: plusDummyTabImage, tag: nil, vc: plusDummyTabVC)
        
        // 4) Friends
        let friendTabTitle: String = Constants.FriendsTab.title
        let friendsTabImage: UIImage? = UIImage(systemName: Constants.FriendsTab.imageName)
        let friendsTabVC: UIViewController = FriendsAssembly.build()
        let friendsTabTag: Int = Constants.FriendsTab.tag
        
        let friendsTab = createTab(title: friendTabTitle, image: friendsTabImage, tag: friendsTabTag, vc: friendsTabVC)
        
        // 5) Settings
        let settingsTabTitle: String = Constants.SettingsTab.title
        let settingsTabImage: UIImage? = UIImage(systemName: Constants.SettingsTab.imageName)
        let settingsTabVC: UIViewController = SettingsAssembly.build()
        let settingsTabTag: Int = Constants.SettingsTab.tag
        
        let settingsTab = createTab(title: settingsTabTitle, image: settingsTabImage, tag: settingsTabTag, vc: settingsTabVC)
        
        self.setViewControllers([
            homeTab,
            analyticsTab,
            plusDummyTab,
            friendsTab,
            settingsTab
        ], animated: false)
    }
    
    private func createTab(title: String, image: UIImage?, tag: Int?, vc: UIViewController) -> UINavigationController {
        let tab = UINavigationController(rootViewController: vc)
        tab.tabBarItem.title = title
        tab.tabBarItem.image = image
        if let tag = tag {
            tab.tabBarItem.tag = tag
        }
        
        return tab
    }
}

// MARK: - presentAddHabitViewController
extension CustomTabBarController {
    func presentAddHabitViewController() {
        let addHabitVC = AddHabitAssembly.build()
        let navController = UINavigationController(rootViewController: addHabitVC)
        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true, completion: nil)
    }
}

// MARK: - UITabBarControllerDelegate
extension CustomTabBarController: UITabBarControllerDelegate {
    // Метод для анимации перехода между табами
    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let vcs = tabBarController.viewControllers,
              let fromIndex = vcs.firstIndex(of: fromVC),
              let toIndex = vcs.firstIndex(of: toVC) else {
            return nil
        }

        let direction: SlideDirection = (toIndex > fromIndex) ? .left : .right
        return SlideTabBarTransitionAnimator(direction: direction)
    }
}
