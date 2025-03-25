//
//  RegistrationPasswordProtocols.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

protocol RegistrationPasswordBusinessLogic {
    func createAccount(_ request: RegistrationPasswordModels.CreateAccount.Request)
}

protocol RegistrationPasswordPresentationLogic {
    func presentCreateAccount(_ response: RegistrationPasswordModels.CreateAccount.Response)
}
