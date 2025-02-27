//
//  WelcomeInteractor.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

final class WelcomeInteractor: WelcomeBusinessLogic {
    // MARK: - Constants
    private let presenter: WelcomePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: WelcomePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func routeToLoginScreen(_ request: WelcomeModels.RouteToLoginScreen.Request) {
        presenter.routeToLoginScreen(WelcomeModels.RouteToLoginScreen.Response())
    }
}
