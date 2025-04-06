//
//  EmailCodeInteractor.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

final class RegistrationEmailCodeInteractor: RegistrationEmailCodeBusinessLogic {
    // MARK: - Constants
    private enum Constants {
        enum EmailMessage {
            static let subject = "Код подтверждения для Doordie"
            static let message = " - Ваш код для подтверждения Doordie."
        }
    }
    
    // MARK: - Constants
    private let presenter: RegistrationEmailCodePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationEmailCodePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func routeToRegistrationNameScreen(_ request: RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Request) {
        presenter.routeToRegistrationNameScreen(RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Response(email: request.email))
    }
    
    func sendEmailMessage(_ request: RegistrationEmailCodeModels.SendEmailMessage.Request) {
        DispatchQueue.global().async {
            let code = (0..<4).map { _ in String(Int.random(in: 0...9)) }.joined()
            
            let headers = [
                "Content-Type": "application/json"
            ]
            
            let sendEmailEndpoint = APIEndpoint(path: .API.sendEmail, method: .POST, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body = RegistrationEmailCodeModels.EmailMessageRequest(
                email: request.email,
                subject: Constants.EmailMessage.subject,
                message: code + Constants.EmailMessage.message
            )
            
            apiService.send(endpoint: sendEmailEndpoint, body: body, responseType: RegistrationEmailCodeModels.EmailMessageResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        if let message = response.detail {
                            print(message)
                        }
                        self.presenter.presentCode(RegistrationEmailCodeModels.SendEmailMessage.Response(code: code))
                        
                    case .failure(let error):
                        print("Ошибка проверки существования почты при авторизации: \(error)")
                    }
                }
            }
        }
    }
}
