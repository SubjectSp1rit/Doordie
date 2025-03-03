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
    func routeToRegistrationNameScreen(_ request: RegistrationEmailModels.RouteToRegistrationNameScreen.Request) {
        presenter.routeToRegistrationNameScreen(RegistrationEmailModels.RouteToRegistrationNameScreen.Response())
    }
}
