//
//  RegistrationEmailProtocols.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

protocol RegistrationEmailBusinessLogic {
    func routeToRegistrationNameScreen(_ request: RegistrationEmailModels.RouteToRegistrationNameScreen.Request)
}

protocol RegistrationEmailPresentationLogic {
    func routeToRegistrationNameScreen(_ response: RegistrationEmailModels.RouteToRegistrationNameScreen.Response)
}
