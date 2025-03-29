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
    
    func presentRegistrationScreen(_ response: LoginModels.RouteToRegistrationScreen.Response) {
        var registrationVC: UIViewController
        if let email = response.email {
            registrationVC = RegistrationEmailAssembly.build(email: email)
        } else {
            registrationVC = RegistrationEmailAssembly.build()
        }
        registrationVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    func presentHomeScreen(_ response: LoginModels.RouteToHomeScreen.Response) {
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate {

            let customTabBarController = CustomTabBarController()
            sceneDelegate.changeRootViewController(customTabBarController)
        }
    }
    
    func presentIfEmailExists(_ response: LoginModels.CheckEmailExists.Response) {
        view?.displayIfEmailExists(LoginModels.CheckEmailExists.ViewModel(isExists: response.isExists, email: response.email))
    }
    
    func presentLoginResult(_ response: LoginModels.LoginUser.Response) {
        view?.displayAfterLogin(LoginModels.LoginUser.viewModel(isSuccess: response.isSuccess))
    }
}
