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
    private let worker: LoginWorker
    
    // MARK: - Lifecycle
    init(presenter: LoginPresentationLogic, worker: LoginWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods
    func showRestorePasswordScreen(_ request: LoginModels.RouteToRestorePasswordScreen.Request) {
        presenter.presentRestorePasswordScreen(LoginModels.RouteToRestorePasswordScreen.Response(email: request.email))
    }
    
    func showRegistrationScreen(_ request: LoginModels.RouteToRegistrationScreen.Request) {
        presenter.presentRegistrationScreen(LoginModels.RouteToRegistrationScreen.Response(email: request.email))
    }
    
    func routeToHomeScreen(_ request: LoginModels.RouteToHomeScreen.Request) {
        presenter.presentHomeScreen(LoginModels.RouteToHomeScreen.Response())
    }
    
    func loginUser(_ request: LoginModels.LoginUser.Request) {
        DispatchQueue.global().async { [weak self] in
            self?.worker.loginUser(request.user) { isSuccess, loginResponse, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        guard let successAuthorization = loginResponse?.is_success else { return }
                        // Кладем токен в keychain
                        if successAuthorization {
                            guard let token = loginResponse?.token else { return }
                            UserDefaultsManager.shared.authToken = token
                            print("Успешный вход по токену: \(token)")
                            self?.presenter.presentLoginResult(LoginModels.LoginUser.Response(isSuccess: true))
                        } else {
                            // Пароль не совпал
                            self?.presenter.presentLoginResult(LoginModels.LoginUser.Response(isSuccess: false))
                        }
                    } else {
                        print("\(message)")
                    }
                }
            }
        }
    }
    
    func checkEmailExists(_ request: LoginModels.CheckEmailExists.Request) {
        DispatchQueue.global().async { [weak self] in
            self?.worker.checkEmailExists(email: request.email) { isSuccess, isExists, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        guard let isExists = isExists?.is_exists else { return }
                        self?.presenter.presentIfEmailExists(LoginModels.CheckEmailExists.Response(isExists: isExists, email: request.email))
                    } else {
                        print("\(message)")
                    }
                }
            }
        }
    }
}
