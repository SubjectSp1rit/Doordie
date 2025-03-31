//
//  RegistrationEmailInteractor.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationEmailInteractor: RegistrationEmailBusinessLogic {
    // MARK: - Constants
    private let presenter: RegistrationEmailPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationEmailPresentationLogic) {
        self.presenter = presenter
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
            let emailEndpoint = APIEndpoint(path: .API.emails, method: .POST)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body = LoginModels.Email(email: request.email)
            
            apiService.send(endpoint: emailEndpoint, body: body, responseType: LoginModels.IsEmailExists.self) { result in
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
