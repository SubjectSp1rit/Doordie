//
//  SceneDelegate.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Для проведения UI-тестов
        if CommandLine.arguments.contains("ui-testing") {
            if CommandLine.arguments.contains("clear-token") {
                UserDefaultsManager.shared.clearAuthToken()
            } else if CommandLine.arguments.contains("set-dummy-token") {
                UserDefaultsManager.shared.authToken = "dummy-token"
            }
        }
        
        // Если пользователь уже авторизован - показываем главный экран
        if UserDefaultsManager.shared.authToken != nil {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = CustomTabBarController()
            self.window = window
            window.makeKeyAndVisible()
        } else { // Иначе - экран авторизации
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: WelcomeAssembly.build())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        
        if animated {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        //(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

