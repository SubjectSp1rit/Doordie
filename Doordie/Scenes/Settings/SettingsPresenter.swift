//
//  SettingsPresenter.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Variables
    weak var view: SettingsViewController?
    
    // MARK: - Public Methods
    func presentTelegram(_ response: SettingsModels.OpenTelegram.Response) {
        showTelegramAlert(channel: response.link)
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
}
