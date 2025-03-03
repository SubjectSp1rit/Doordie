//
//  WelcomeProtocols.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

protocol WelcomeBusinessLogic {
    func routeToLoginScreen(_ request: WelcomeModels.RouteToLoginScreen.Request)
    func routeToRegistrationScreen(_ request: WelcomeModels.RouteToRegistrationScreen.Request)
}

protocol WelcomePresentationLogic {
    func routeToLoginScreen(_ response: WelcomeModels.RouteToLoginScreen.Response)
    func routeToRegistrationScreen(_ response: WelcomeModels.RouteToRegistrationScreen.Response)
}
