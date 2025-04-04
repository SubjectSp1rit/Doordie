//
//  SettingsProtocols.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

protocol SettingsBusinessLogic {
    func routeToProfileScreen(_ request: SettingsModels.RouteToProfileScreen.Request)
    func openTelegram(_ request: SettingsModels.OpenTelegram.Request)
    func showLogoutAlert(_ request: SettingsModels.ShowLogoutAlert.Request)
}

protocol SettingsPresentationLogic {
    func routeToProfileScreen(_ response: SettingsModels.RouteToProfileScreen.Response)
    func presentTelegram(_ response: SettingsModels.OpenTelegram.Response)
    func presentLogoutAlert(_ response: SettingsModels.ShowLogoutAlert.Response)
}
