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
            guard let token = UserDefaultsManager.shared.authToken else { return }
            let headers = [
                "Content-Type": "application/json",
                "Token": token
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
    
    func updateHabitExecution(_ request: HabitExecutionModels.UpdateHabitExecution.Request) {
        DispatchQueue.global().async {
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let currentDate = dateFormatter.string(from: Date())
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token,
                "Date": currentDate
            ]
            
            let habitsEndpoint = APIEndpoint(path: .API.habitExecution, method: .PUT, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body: HabitModel = request.habit
            
            apiService.send(endpoint: habitsEndpoint, body: body, responseType: HabitExecutionModels.UpdateHabitResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        print(response.detail ?? "Привычка успешно обновлена")
                        request.onDismiss()
                        
                    case .failure(let error):
                        print("Ошибка обновления привычки: \(error)")
                        request.onDismiss()
                    }
                }
            }
        }
    }
}
