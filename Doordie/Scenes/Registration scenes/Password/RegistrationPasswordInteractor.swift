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
    private let worker: RegistrationPasswordWorker
    
    // MARK: - Lifecycle
    init(presenter: RegistrationPasswordPresentationLogic, worker: RegistrationPasswordWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods
    func createAccount(_ request: RegistrationPasswordModels.CreateAccount.Request) {
        DispatchQueue.global().async {
            self.worker.createAccount(request.user) { [weak self] isSuccess, message, token in
                DispatchQueue.main.async {
                    if isSuccess {
                        guard let token = token else { return }
                        UserDefaultsManager.shared.authToken = token.token
                        print("Успешный вход по токену: \(token)")
                        self?.presenter.presentCreateAccount(RegistrationPasswordModels.CreateAccount.Response())
                    } else {
                        print("Вход не выполнен: \(message)")
                    }
                }
            }
        }
    }
}
