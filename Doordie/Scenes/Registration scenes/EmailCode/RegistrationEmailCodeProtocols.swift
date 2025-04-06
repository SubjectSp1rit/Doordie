//
//  EmailCodeProtocols.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

protocol RegistrationEmailCodeBusinessLogic {
    func routeToRegistrationNameScreen(_ request: RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Request)
    func sendEmailMessage(_ request: RegistrationEmailCodeModels.SendEmailMessage.Request)
}

protocol RegistrationEmailCodePresentationLogic {
    func routeToRegistrationNameScreen(_ response: RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Response)
    func presentCode(_ response: RegistrationEmailCodeModels.SendEmailMessage.Response)
}
