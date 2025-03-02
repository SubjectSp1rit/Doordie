//
//  PasswordResetProtocols.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

protocol PasswordResetBusinessLogic {
    func showSentPopup(_ request: PasswordResetModels.PresentSentPopup.Request)
}

protocol PasswordResetPresentationLogic {
    func presentSentPopup(_ response: PasswordResetModels.PresentSentPopup.Response)
}
