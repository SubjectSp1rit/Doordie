//
//  RegistrationNameInteractor.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationNameInteractor: RegistrationNameBusinessLogic {
    // MARK: - Constants
    private let presenter: RegistrationNamePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationNamePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func routeToRegistrationPassword(_ request: RegistrationNameModels.RouteToRegistrationPasswordScreen.Request) {
        presenter.routeToRegistrationPassword(RegistrationNameModels.RouteToRegistrationPasswordScreen.Response(email: request.email, name: request.name))
    }
}
