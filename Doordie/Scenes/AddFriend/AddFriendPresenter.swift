//
//  AddFriendPresenter.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

final class AddFriendPresenter: AddFriendPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        enum FriendAddedPopup {
            static let title: String = "Success"
            static let message: String = "Friend request sent successfully"
            static let okTitle: String = "OK"
        }
    }
    
    // MARK: - Properties
    weak var view: AddFriendViewController?
    
    // MARK: - Methods
    func presentFriendRequest(_ response: AddFriendModels.SendFriendRequest.Response) {
        let message = Constants.FriendAddedPopup.message
        let confirmationAlert: UIAlertController = UIAlertController(title: Constants.FriendAddedPopup.title, message: message, preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: Constants.FriendAddedPopup.okTitle, style: .default) { _ in
            self.view?.navigationController?.popViewController(animated: true)
        }
        
        confirmationAlert.addAction(okAction)
        
        view?.present(confirmationAlert, animated: true, completion: nil)
    }
}
