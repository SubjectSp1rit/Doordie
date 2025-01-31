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
}

protocol SettingsPresentationLogic {
    func presentTelegram(_ response: SettingsModels.OpenTelegram.Response)
}
