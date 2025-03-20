//
//  RegistrationEmailInteractor.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationEmailInteractor: RegistrationEmailBusinessLogic {
    // MARK: - Constants
    private let presenter: RegistrationEmailPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationEmailPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func routeToRegistrationEmailCodeScreen(_ request: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Request) {
        presenter.routeToRegistrationEmailCodeScreen(RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response(email: request.email))
    }
}
