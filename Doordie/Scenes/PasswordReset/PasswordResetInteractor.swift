//
//  PasswordResetInteractor.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

final class PasswordResetInteractor: PasswordResetBusinessLogic {
    // MARK: - Constants
    private let presenter: PasswordResetPresentationLogic
    private let apiService: APIServiceProtocol
    
    // MARK: - Lifecycle
    init(presenter: PasswordResetPresentationLogic, apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    // MARK: - Methods
    func showSentPopup(_ request: PasswordResetModels.PresentSentPopup.Request) {
        presenter.presentSentPopup(PasswordResetModels.PresentSentPopup.Response(mail: request.mail))
    }
    
    func routeToRegistrationEmailScreen(_ request: PasswordResetModels.RouteToRegistrationEmailScreen.Request) {
        presenter.routeToRegistrationEmailScreen(PasswordResetModels.RouteToRegistrationEmailScreen.Response(email: request.email))
    }
    
    func checkEmailExists(_ request: PasswordResetModels.CheckEmailExists.Request) {
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
                        self?.presenter.presentIfEmailExists(PasswordResetModels.CheckEmailExists.Response(isExists: isExists, email: request.email))
                        
                    case .failure(let error):
                        print("Ошибка проверки существования почты при авторизации: \(error)")
                    }
                }
            }
        }
    }
}
