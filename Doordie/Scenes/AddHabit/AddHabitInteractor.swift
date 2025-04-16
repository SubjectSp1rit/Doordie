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
    private let apiService: APIServiceProtocol
    
    // MARK: - Lifecycle
    init(presenter: AddHabitPresentationLogic, apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    // MARK: - Methods
    func updateHabit(_ request: AddHabitModels.UpdateHabit.Request) {
        DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let habitsEndpoint = APIEndpoint(path: .API.habits, method: .PUT, headers: headers)
            
            let body: HabitModel = request.habit
            
            self?.apiService.send(endpoint: habitsEndpoint, body: body, responseType: AddHabitModels.UpdateHabitResponse.self) { result in
                switch result {
                    
                case .success(let response):
                    guard let message = response.detail else { return }
                    print(message)
                    self?.presenter.presentUpdatedHabit(AddHabitModels.UpdateHabit.Response())
                    
                case .failure(let error):
                    print("Ошибка обновления привычки: \(error)")
                }
            }
        }
    }
    
    func createHabit(_ request: AddHabitModels.CreateHabit.Request) {
        DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let habitsEndpoint = APIEndpoint(path: .API.habits, method: .POST, headers: headers)
            
            let body: HabitModel = request.habit
            
            self?.apiService.send(endpoint: habitsEndpoint, body: body, responseType: AddHabitModels.CreateHabitResponse.self) { result in
                switch result {
                    
                case .success(let response):
                    guard let message = response.detail else { return }
                    print(message)
                    self?.presenter.presentHabitsAfterCreating(AddHabitModels.CreateHabit.Response())
                    
                case .failure(let error):
                    print("Ошибка создания привычки: \(error)")
                }
            }
        }
    }
}
