//
//  PasswordResetInteractor.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

final class PasswordResetInteractor: PasswordResetBusinessLogic {
    // MARK: - Constants
    private let presenter: PasswordResetPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: PasswordResetPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func showSentPopup(_ request: PasswordResetModels.PresentSentPopup.Request) {
        presenter.presentSentPopup(PasswordResetModels.PresentSentPopup.Response(mail: request.mail))
    }
}
