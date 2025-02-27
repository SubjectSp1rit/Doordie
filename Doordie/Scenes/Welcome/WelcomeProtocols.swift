//
//  WelcomeProtocols.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

protocol WelcomeBusinessLogic {
    func routeToLoginScreen(_ request: WelcomeModels.RouteToLoginScreen.Request)
}

protocol WelcomePresentationLogic {
    func routeToLoginScreen(_ response: WelcomeModels.RouteToLoginScreen.Response)
}
