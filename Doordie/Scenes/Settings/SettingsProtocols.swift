//
//  SettingsProtocols.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

protocol SettingsBusinessLogic {
    func openTelegram(_ request: SettingsModels.OpenTelegram.Request)
    func showLogoutAlert(_ request: SettingsModels.ShowLogoutAlert.Request)
}

protocol SettingsPresentationLogic {
    func presentTelegram(_ response: SettingsModels.OpenTelegram.Response)
    func presentLogoutAlert(_ response: SettingsModels.ShowLogoutAlert.Response)
}
