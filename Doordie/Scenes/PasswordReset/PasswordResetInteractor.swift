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
    
    // MARK: - Lifecycle
    init(presenter: PasswordResetPresentationLogic) {
        self.presenter = presenter
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
            let emailEndpoint = APIEndpoint(path: .API.emails, method: .POST)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body = LoginModels.Email(email: request.email)
            
            apiService.send(endpoint: emailEndpoint, body: body, responseType: LoginModels.IsEmailExists.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let isEmailExists):
                        guard let isExists = isEmailExists.is_exists else { return }
                        self?.presenter.presentIfEmailExists(PasswordResetModels.CheckEmailExists.Response(isExists: isExists, email: request.email))
                        
                    case .failure(let error):
                        print("Ошибка проверки существования почты при авторизации: \(error)")
                    }
                }
            }
        }
    }
}
