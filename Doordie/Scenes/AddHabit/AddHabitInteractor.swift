//
//  AddHabitInteractor.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class AddHabitInteractor: AddHabitBusinessLogic {
    // MARK: - Constants
    private let presenter: AddHabitPresentationLogic
    private let worker: AddHabitWorker
    
    // MARK: - Lifecycle
    init(presenter: AddHabitPresentationLogic, worker: AddHabitWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods
    func updateHabit(_ request: AddHabitModels.UpdateHabit.Request) {
        DispatchQueue.global().async {
            self.worker.updateHabit(request.habit) { [weak self] isSuccess, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        print("Привычки успешно обновлена")
                        self?.presenter.presentUpdatedHabit(AddHabitModels.UpdateHabit.Response())
                    } else {
                        print("Ошибка обновления привычки: \(message)")
                    }
                }
            }
        }
    }
    
    func createHabit(_ request: AddHabitModels.CreateHabit.Request) {
        DispatchQueue.global().async {
            self.worker.createHabit(request.habit) { [weak self] isSuccess, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        print("Привычка успешно добавлена")
                        self?.presenter.presentHabitsAfterCreating(AddHabitModels.CreateHabit.Response())
                    } else {
                        print("Ошибка добавления привычки: \(message)")
                    }
                }
            }
        }
    }
}
