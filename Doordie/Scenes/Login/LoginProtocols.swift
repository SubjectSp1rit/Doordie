//
//  LoginProtocols.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

protocol LoginBusinessLogic {
    func showRestorePasswordScreen(_ request: LoginModels.RouteToRestorePasswordScreen.Request)
}

protocol LoginPresentationLogic {
    func presentRestorePasswordScreen(_ response: LoginModels.RouteToRestorePasswordScreen.Response)
}
