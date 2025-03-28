//
//  RegistrationEmailProtocols.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

protocol RegistrationEmailBusinessLogic {
    func routeToRegistrationEmailCodeScreen(_ request: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Request)
    func routeToLoginScreen(_ request: RegistrationEmailModels.RouteToLoginScreen.Request)
    func checkEmailExists(_ request: RegistrationEmailModels.CheckEmailExists.Request)
}

protocol RegistrationEmailPresentationLogic {
    func routeToRegistrationEmailCodeScreen(_ response: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response)
    func routeToLoginScreen(_ response: RegistrationEmailModels.RouteToLoginScreen.Response)
    func presentIfEmailExists(_ response: RegistrationEmailModels.CheckEmailExists.Response)
}
