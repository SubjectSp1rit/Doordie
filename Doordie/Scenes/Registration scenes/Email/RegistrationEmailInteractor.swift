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
    private let worker: RegistrationEmailWorker
    
    // MARK: - Lifecycle
    init(presenter: RegistrationEmailPresentationLogic, worker: RegistrationEmailWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public Methods
    func routeToRegistrationEmailCodeScreen(_ request: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Request) {
        presenter.routeToRegistrationEmailCodeScreen(RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response(email: request.email))
    }
    
    func routeToLoginScreen(_ request: RegistrationEmailModels.RouteToLoginScreen.Request) {
        presenter.routeToLoginScreen(RegistrationEmailModels.RouteToLoginScreen.Response(email: request.email))
    }
    
    func checkEmailExists(_ request: RegistrationEmailModels.CheckEmailExists.Request) {
        DispatchQueue.global().async {
            self.worker.checkEmailExists(email: request.email) { [weak self] isSuccess, isExists, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        guard let isExists = isExists?.is_exists else { return }
                        self?.presenter.presentIfEmailExists(RegistrationEmailModels.CheckEmailExists.Response(isExists: isExists, email: request.email))
                    } else {
                        print("\(message)")
                    }
                }
            }
        }
    }
}
