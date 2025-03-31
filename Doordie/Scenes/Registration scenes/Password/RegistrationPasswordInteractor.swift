//
//  RegistrationPasswordInteractor.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationPasswordInteractor: RegistrationPasswordBusinessLogic {
    // MARK: - Constants
    private let presenter: RegistrationPasswordPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationPasswordPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func createAccount(_ request: RegistrationPasswordModels.CreateAccount.Request) {
        DispatchQueue.global().async { [weak self] in
            let headers = [
                "Content-Type": "application/json"
            ]
            
            let registerEndpoint = APIEndpoint(path: .API.register, method: .POST, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body = User(email: request.email, name: request.name, password: request.password)
            
            apiService.send(endpoint: registerEndpoint, body: body, responseType: Token.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        guard let token = response.token else { return }
                        UserDefaultsManager.shared.authToken = token
                        print("Успешная регистрация и вход по токену: \(token)")
                        self?.presenter.presentCreateAccount(RegistrationPasswordModels.CreateAccount.Response())
                        
                    case .failure(let error):
                        print("Ошибка регистрации аккаунта: \(error)")
                    }
                }
            }
        }
    }
}
