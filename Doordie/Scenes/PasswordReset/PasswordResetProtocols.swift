//
//  PasswordResetProtocols.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

protocol PasswordResetBusinessLogic {
    func showSentPopup(_ request: PasswordResetModels.PresentSentPopup.Request)
    func checkEmailExists(_ request: PasswordResetModels.CheckEmailExists.Request)
    func routeToRegistrationEmailScreen(_ request: PasswordResetModels.RouteToRegistrationEmailScreen.Request)
}

protocol PasswordResetPresentationLogic {
    func presentSentPopup(_ response: PasswordResetModels.PresentSentPopup.Response)
    func presentIfEmailExists(_ response: PasswordResetModels.CheckEmailExists.Response)
    func routeToRegistrationEmailScreen(_ response: PasswordResetModels.RouteToRegistrationEmailScreen.Response)
}
