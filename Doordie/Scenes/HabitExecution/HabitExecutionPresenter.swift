//
//  HabitExecutionPresenter.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

final class HabitExecutionPresenter: HabitExecutionPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        enum ConfirmationAlert {
            static let title: String = "Confirm deleting"
            static let message: String = "Are you sure you want to delete"
            static let cancelTitle: String = "Cancel"
            static let deleteTitle: String = "Delete"
        }
    }
    // MARK: - Properties
    weak var view: HabitExecutionViewController?
    
    // MARK: - Public Methods
    func presentDeleteConfirmationMessage(_ response: HabitExecutionModels.ShowDeleteConfirmationMessage.Response) {
        guard let habitTitle: String = response.habit.title else { return }
        
        let message = "\(Constants.ConfirmationAlert.message) \(habitTitle)?"
        let confirmationAlert: UIAlertController = UIAlertController(title: Constants.ConfirmationAlert.title, message: message, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: Constants.ConfirmationAlert.cancelTitle, style: .cancel)
        let deleteAction: UIAlertAction = UIAlertAction(title: Constants.ConfirmationAlert.deleteTitle, style: .default) {_ in 
            response.habit.deleteHabit()
            self.view?.displayHabitsAfterDeleting(HabitExecutionModels.ShowDeleteConfirmationMessage.ViewModel())
        }
        
        confirmationAlert.addAction(cancelAction)
        confirmationAlert.addAction(deleteAction)
        
        view?.present(confirmationAlert, animated: true, completion: nil)
    }
}
