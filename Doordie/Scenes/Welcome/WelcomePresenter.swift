//
//  WelcomePresenter.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

final class WelcomePresenter: WelcomePresentationLogic {
    // MARK: - Properties
    weak var view: WelcomeViewController?
    
    // MARK: - Public Methods
    func routeToLoginScreen(_ response: WelcomeModels.RouteToLoginScreen.Response) {
        let loginVC = LoginAssembly.build()
        loginVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func routeToRegistrationScreen(_ response: WelcomeModels.RouteToRegistrationScreen.Response) {
        let registrationVC = RegistrationEmailAssembly.build()
        registrationVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registrationVC, animated: true)
    }
}
