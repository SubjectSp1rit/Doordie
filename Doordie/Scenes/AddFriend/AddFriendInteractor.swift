//
//  AddFriendInteractor.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

final class AddFriendInteractor: AddFriendBusinessLogic {
    // MARK: - Constants
    private let presenter: AddFriendPresentationLogic
    private let apiService: APIServiceProtocol
    
    // MARK: - Lifecycle
    init(presenter: AddFriendPresentationLogic, apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    // MARK: - Methods
    func sendFriendRequest(_ request: AddFriendModels.SendFriendRequest.Request) {
        DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let emailEndpoint = APIEndpoint(path: .API.friends, method: .POST, headers: headers)
            
            let body = AddFriendModels.Email(email: request.email)
            
            self?.apiService.send(endpoint: emailEndpoint, body: body, responseType: AddFriendModels.AddFriendResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        if let message = response.detail {
                            print(message)
                        }
                        
                    case .failure(let error):
                        print("Ошибка проверки существования почты при авторизации: \(error)")
                    }
                    
                    self?.presenter.presentFriendRequest(AddFriendModels.SendFriendRequest.Response())
                }
            }
        }
    }
}
