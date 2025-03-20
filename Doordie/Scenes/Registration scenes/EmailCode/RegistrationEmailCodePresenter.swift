//
//  EmailCodePresenter.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

final class RegistrationEmailCodePresenter: RegistrationEmailCodePresentationLogic {
    // MARK: - Properties
    weak var view: RegistrationEmailCodeViewController?
    
    // MARK: - Methods
    func routeToRegistrationNameScreen(_ response: RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Response) {
        let registrationNameVC = RegistrationNameAssembly.build(email: response.email)
        registrationNameVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registrationNameVC, animated: true)
    }
}
