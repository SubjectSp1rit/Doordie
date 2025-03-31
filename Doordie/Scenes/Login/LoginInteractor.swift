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
            let headers = [
                "Content-Type": "application/json"
            ]
            
            let loginEndpoint = APIEndpoint(path: .API.login, method: .POST, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body = User(email: request.email, name: nil, password: request.password)
            
            apiService.send(endpoint: loginEndpoint, body: body, responseType: LoginModels.LoginResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let loginResponse):
                        guard let isPasswordCorrect = loginResponse.is_success else { return }
                        
                        // Если пароль совпал - значит пришел и  токен, который нужно сохранить
                        if isPasswordCorrect {
                            guard let token = loginResponse.token else { return }
                            UserDefaultsManager.shared.authToken = token
                            print("Успешный вход по токену: \(token)")
                        }
                        
                        self?.presenter.presentLoginResult(LoginModels.LoginUser.Response(isSuccess: isPasswordCorrect))
                        
                    case .failure(let error):
                        print("Ошибка входа в аккаунт: \(error)")
                    }
                }
            }
        }
    }
    
    func checkEmailExists(_ request: LoginModels.CheckEmailExists.Request) {
        DispatchQueue.global().async { [weak self] in
            let headers = [
                "Content-Type": "application/json"
            ]
            
            let emailEndpoint = APIEndpoint(path: .API.emails, method: .POST, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body = LoginModels.Email(email: request.email)
            
            apiService.send(endpoint: emailEndpoint, body: body, responseType: LoginModels.IsEmailExists.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        guard let isExists = response.is_exists else { return }
                        self?.presenter.presentIfEmailExists(LoginModels.CheckEmailExists.Response(isExists: isExists, email: request.email))
                        
                    case .failure(let error):
                        print("Ошибка проверки существования почты при авторизации: \(error)")
                    }
                }
            }
        }
    }
}
