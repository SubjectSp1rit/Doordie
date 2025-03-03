//
//  RegistrationNameProtocols.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

protocol RegistrationNameBusinessLogic {
    func routeToRegistrationPassword(_ request: RegistrationNameModels.RouteToRegistrationPasswordScreen.Request)
}

protocol RegistrationNamePresentationLogic {
    func routeToRegistrationPassword(_ response: RegistrationNameModels.RouteToRegistrationPasswordScreen.Response)
}
