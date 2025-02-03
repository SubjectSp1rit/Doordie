//
//  HabitExecutionInteractor.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

final class HabitExecutionInteractor: HabitExecutionBusinessLogic {
    // MARK: - Constants
    private let presenter: HabitExecutionPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: HabitExecutionPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func showDeleteConfirmationMessage(_ request: HabitExecutionModels.ShowDeleteConfirmationMessage.Request) {
        presenter.presentDeleteConfirmationMessage(HabitExecutionModels.ShowDeleteConfirmationMessage.Response(habit: request.habit))
    }
}
