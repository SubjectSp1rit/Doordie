//
//  RegistrationEmailPresenter.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationEmailPresenter: RegistrationEmailPresentationLogic {
    // MARK: - Properties
    weak var view: RegistrationEmailViewController?
    
    // MARK: - Public Methods
    func routeToRegistrationEmailCodeScreen(_ response: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response) {
        let registrationEmailCodeVC = RegistrationEmailCodeAssembly.build(email: response.email)
        registrationEmailCodeVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registrationEmailCodeVC, animated: true)
    }
}
