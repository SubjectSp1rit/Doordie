//
//  RegistrationEmailProtocols.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

protocol RegistrationEmailBusinessLogic {
    func routeToRegistrationEmailCodeScreen(_ request: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Request)
}

protocol RegistrationEmailPresentationLogic {
    func routeToRegistrationEmailCodeScreen(_ response: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response)
}
