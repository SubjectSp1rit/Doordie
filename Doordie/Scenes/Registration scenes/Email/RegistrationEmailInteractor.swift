//
//  RegistrationEmailInteractor.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationEmailInteractor: RegistrationEmailBusinessLogic {
    // MARK: - Constants
    private enum Constants {
        enum EmailMessage {
            static let subject = "Код подтверждения для Doordie"
            static let message = "Ваш код подтверждения: "
        }
    }
    
    private let presenter: RegistrationEmailPresentationLogic
    private let apiService: APIServiceProtocol
    
    // MARK: - Lifecycle
    init(presenter: RegistrationEmailPresentationLogic, apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    // MARK: - Public Methods
    func routeToRegistrationEmailCodeScreen(_ request: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Request) {
        presenter.routeToRegistrationEmailCodeScreen(RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response(email: request.email))
    }
    
    func routeToLoginScreen(_ request: RegistrationEmailModels.RouteToLoginScreen.Request) {
        presenter.routeToLoginScreen(RegistrationEmailModels.RouteToLoginScreen.Response(email: request.email))
    }
    
    func checkEmailExists(_ request: RegistrationEmailModels.CheckEmailExists.Request) {
        DispatchQueue.global().async { [weak self] in
            let headers = [
                "Content-Type": "application/json"
            ]
            
            let emailEndpoint = APIEndpoint(path: .API.emails, method: .POST, headers: headers)
            
            let body = LoginModels.Email(email: request.email)
            
            self?.apiService.send(endpoint: emailEndpoint, body: body, responseType: LoginModels.IsEmailExists.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        guard let isExists = response.is_exists else { return }
                        self?.presenter.presentIfEmailExists(RegistrationEmailModels.CheckEmailExists.Response(isExists: isExists, email: request.email))
                        
                    case .failure(let error):
                        print("Ошибка проверки существования почты при авторизации: \(error)")
                    }
                }
            }
        }
    }
}
