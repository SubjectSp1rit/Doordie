//
//  RegistrationNamePresenter.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationNamePresenter: RegistrationNamePresentationLogic {
    // MARK: - Properties
    weak var view: RegistrationNameViewController?
    
    // MARK: - Public Methods
    func routeToRegistrationPassword(_ response: RegistrationNameModels.RouteToRegistrationPasswordScreen.Response) {
        let registrationPasswordVC = RegistrationPasswordAssembly.build(email: response.email, name: response.name)
        registrationPasswordVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registrationPasswordVC, animated: true)
    }
}
