//
//  LoginInteractor.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

final class LoginInteractor: LoginBusinessLogic {
    // MARK: - Constants
    private let presenter: LoginPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: LoginPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func showRestorePasswordScreen(_ request: LoginModels.RouteToRestorePasswordScreen.Request) {
        presenter.presentRestorePasswordScreen(LoginModels.RouteToRestorePasswordScreen.Response())
    }
}
