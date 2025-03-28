//
//  PasswordResetPresenter.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

final class PasswordResetPresenter: PasswordResetPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        enum SentPopup {
            static let title: String = "Success"
            static let message: String = "Instructions sent to"
            static let okTitle: String = "OK"
        }
    }
    
    // MARK: - Properties
    weak var view: PasswordResetViewController?
    
    // MARK: - Methods
    func presentSentPopup(_ response: PasswordResetModels.PresentSentPopup.Response) {
        let message = "\(Constants.SentPopup.message) \(response.mail)"
        let confirmationAlert: UIAlertController = UIAlertController(title: Constants.SentPopup.title, message: message, preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: Constants.SentPopup.okTitle, style: .default) { _ in
            self.view?.navigationController?.popViewController(animated: true)
        }
        
        confirmationAlert.addAction(okAction)
        
        view?.present(confirmationAlert, animated: true, completion: nil)
    }
    
    func presentIfEmailExists(_ response: PasswordResetModels.CheckEmailExists.Response) {
        view?.displayIfEmailExists(PasswordResetModels.CheckEmailExists.ViewModel(isExists: response.isExists, email: response.email))
    }
    
    func routeToRegistrationEmailScreen(_ response: PasswordResetModels.RouteToRegistrationEmailScreen.Response) {
        let registrationEmailVC = RegistrationEmailAssembly.build(email: response.email)
        registrationEmailVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(registrationEmailVC, animated: true)
    }
}
