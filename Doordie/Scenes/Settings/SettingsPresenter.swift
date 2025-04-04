//
//  SettingsPresenter.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        enum LogoutAlert {
            static let title: String = "Are you sure you want to log out?"
            static let message: String = ""
            static let okTitle: String = "Logout"
            static let cancelTitle: String = "Cancel"
        }
    }
    
    // MARK: - Variables
    weak var view: SettingsViewController?
    
    // MARK: - Public Methods
    func presentTelegram(_ response: SettingsModels.OpenTelegram.Response) {
        showTelegramAlert(channel: response.link)
    }
    
    func presentLogoutAlert(_ response: SettingsModels.ShowLogoutAlert.Response) {
        let confirmationAlert: UIAlertController = UIAlertController(title: Constants.LogoutAlert.title, message: Constants.LogoutAlert.message, preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: Constants.LogoutAlert.okTitle, style: .default) { _ in
            UserDefaultsManager.shared.clearAuthToken()
            UserDefaultsManager.shared.clearName()
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate {

                let welcomeVC = UINavigationController(rootViewController: WelcomeAssembly.build())
                sceneDelegate.changeRootViewController(welcomeVC)
            }
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: Constants.LogoutAlert.cancelTitle, style: .cancel, handler: nil)
        
        confirmationAlert.addAction(okAction)
        confirmationAlert.addAction(cancelAction)
        
        view?.present(confirmationAlert, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func showTelegramAlert(channel: String) {
        let alert = UIAlertController(
            title: "Are you sure you want to open telegram?",
            message: "",
            preferredStyle: .alert
        )
        
        let openAction = UIAlertAction(title: "Open", style: .default) { _ in
            self.openTelegramChannel(channel: channel)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(openAction)
        alert.addAction(cancelAction)
        
        view?.present(alert, animated: true, completion: nil)
    }
    
    private func openTelegramChannel(channel: String) {
        guard let appURL = URL(string: "tg://resolve?domain=\(channel)") else { return }
        guard let webURL = URL(string: "https://t.me/\(channel)") else { return }
    
        // Открывает приложение, если оно скачано, иначе браузер
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    func routeToProfileScreen(_ response: SettingsModels.RouteToProfileScreen.Response) {
        let profileVC = ProfileAssembly.build()
        profileVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(profileVC, animated: true)
    }
}
