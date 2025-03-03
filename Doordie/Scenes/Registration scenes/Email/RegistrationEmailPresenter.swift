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
    func routeToRegistrationNameScreen(_ response: RegistrationEmailModels.RouteToRegistrationNameScreen.Response) {
        let registrationNameVC = RegistrationNameAssembly.build()
        registrationNameVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registrationNameVC, animated: true)
    }
}
