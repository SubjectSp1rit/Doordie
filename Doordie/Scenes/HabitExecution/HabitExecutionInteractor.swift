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
    private let worker: HabitExecutionWorker
    
    // MARK: - Lifecycle
    init(presenter: HabitExecutionPresentationLogic, worker: HabitExecutionWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public Methods
    func showDeleteConfirmationMessage(_ request: HabitExecutionModels.ShowDeleteConfirmationMessage.Request) {
        presenter.presentDeleteConfirmationMessage(HabitExecutionModels.ShowDeleteConfirmationMessage.Response(habit: request.habit))
    }
    
    func showEditHabitScreen(_ request: HabitExecutionModels.ShowEditHabitScreen.Request) {
        presenter.presentEditHabitScreen(HabitExecutionModels.ShowEditHabitScreen.Response(habit: request.habit))
    }
    
    func deleteHabit(_ request: HabitExecutionModels.DeleteHabit.Request) {
        DispatchQueue.global().async {
            self.worker.deleteHabit(habit: request.habit) { [weak self] isSuccess, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        print("Привычка успешно удалена")
                        self?.presenter.presentHabitsAfterDeleting(HabitExecutionModels.DeleteHabit.Response())
                    } else {
                        print("Ошибка получения привычек: \(message)")
                    }
                }
            }
        }
    }
}
