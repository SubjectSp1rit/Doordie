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
    
    func showEditHabitScreen(_ request: HabitExecutionModels.ShowEditHabitScreen.Request) {
        presenter.presentEditHabitScreen(HabitExecutionModels.ShowEditHabitScreen.Response(habit: request.habit))
    }
    
    func deleteHabit(_ request: HabitExecutionModels.DeleteHabit.Request) {
        DispatchQueue.global().async { [weak self] in
            let headers = [
                "Content-Type": "application/json"
            ]
            
            let habitsEndpoint = APIEndpoint(path: .API.habits, method: .DELETE, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body: HabitModel = request.habit
            
            apiService.send(endpoint: habitsEndpoint, body: body, responseType: HabitExecutionModels.DeleteHabitResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        guard let message = response.detail else { return }
                        print(message)
                        self?.presenter.presentHabitsAfterDeleting(HabitExecutionModels.DeleteHabit.Response())
                        
                    case .failure(let error):
                        print("Ошибка удаления привычки: \(error)")
                    }
                }
            }
        }
    }
}
