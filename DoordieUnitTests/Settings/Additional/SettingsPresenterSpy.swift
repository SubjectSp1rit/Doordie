//
//  SettingsPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class SettingsPresenterSpy: SettingsPresentationLogic {
    var routeToProfileScreenCalled = false
    var telegramResponse: SettingsModels.OpenTelegram.Response?
    var logoutAlertCalled = false

    func routeToProfileScreen(_ response: SettingsModels.RouteToProfileScreen.Response) {
        routeToProfileScreenCalled = true
    }
    
    func presentTelegram(_ response: SettingsModels.OpenTelegram.Response) {
        telegramResponse = response
    }
    
    func presentLogoutAlert(_ response: SettingsModels.ShowLogoutAlert.Response) {
        logoutAlertCalled = true
    }
}
