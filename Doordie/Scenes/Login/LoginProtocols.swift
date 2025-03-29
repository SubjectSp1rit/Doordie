//
//  LoginProtocols.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

protocol LoginBusinessLogic {
    func showRestorePasswordScreen(_ request: LoginModels.RouteToRestorePasswordScreen.Request)
    func showRegistrationScreen(_ request: LoginModels.RouteToRegistrationScreen.Request)
    func routeToHomeScreen(_ request: LoginModels.RouteToHomeScreen.Request)
    func checkEmailExists(_ request: LoginModels.CheckEmailExists.Request)
    func loginUser(_ request: LoginModels.LoginUser.Request)
}

protocol LoginPresentationLogic {
    func presentRestorePasswordScreen(_ response: LoginModels.RouteToRestorePasswordScreen.Response)
    func presentRegistrationScreen(_ response: LoginModels.RouteToRegistrationScreen.Response)
    func presentHomeScreen(_ response: LoginModels.RouteToHomeScreen.Response)
    func presentIfEmailExists(_ response: LoginModels.CheckEmailExists.Response)
    func presentLoginResult(_ response: LoginModels.LoginUser.Response)
}
