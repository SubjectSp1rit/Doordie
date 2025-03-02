//
//  LoginPresenter.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

final class LoginPresenter: LoginPresentationLogic {
    // MARK: - Properties
    weak var view: LoginViewController?
    
    // MARK: - Methods
    func presentRestorePasswordScreen(_ response: LoginModels.RouteToRestorePasswordScreen.Response) {
        let restorePasswordVC = PasswordResetAssembly.build(email: response.email)
        restorePasswordVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(restorePasswordVC, animated: true)
    }
}
