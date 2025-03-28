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
    private let worker: PasswordResetWorker
    
    // MARK: - Lifecycle
    init(presenter: PasswordResetPresentationLogic, worker: PasswordResetWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods
    func showSentPopup(_ request: PasswordResetModels.PresentSentPopup.Request) {
        presenter.presentSentPopup(PasswordResetModels.PresentSentPopup.Response(mail: request.mail))
    }
    
    func routeToRegistrationEmailScreen(_ request: PasswordResetModels.RouteToRegistrationEmailScreen.Request) {
        presenter.routeToRegistrationEmailScreen(PasswordResetModels.RouteToRegistrationEmailScreen.Response(email: request.email))
    }
    
    func checkEmailExists(_ request: PasswordResetModels.CheckEmailExists.Request) {
        DispatchQueue.global().async {
            self.worker.checkEmailExists(email: request.email) { [weak self] isSuccess, isExists, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        guard let isExists = isExists?.is_exists else { return }
                        self?.presenter.presentIfEmailExists(PasswordResetModels.CheckEmailExists.Response(isExists: isExists, email: request.email))
                    } else {
                        print("\(message)")
                    }
                }
            }
        }
    }
}
