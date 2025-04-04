//
//  SettingsInteractor.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class SettingsInteractor: SettingsBusinessLogic {
    // MARK: - Constants
    private let presenter: SettingsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: SettingsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func openTelegram(_ request: SettingsModels.OpenTelegram.Request) {
        presenter.presentTelegram(SettingsModels.OpenTelegram.Response(link: request.link))
    }
    
    func showLogoutAlert(_ request: SettingsModels.ShowLogoutAlert.Request) {
        presenter.presentLogoutAlert(SettingsModels.ShowLogoutAlert.Response())
    }
    
    func routeToProfileScreen(_ request: SettingsModels.RouteToProfileScreen.Request) {
        presenter.routeToProfileScreen(SettingsModels.RouteToProfileScreen.Response())
    }
}
