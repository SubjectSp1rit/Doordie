//
//  HomeInteractor.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import UIKit

final class HomeInteractor: HomeBusinessLogic, HabitsStorage {
    // MARK: - Constants
    private let presenter: HomePresentationLogic
    private let apiService: APIServiceProtocol
    
    // MARK: - Properties
    internal var habits: [HabitModel] = [] {
        didSet {
            presenter.presentHabits(HomeModels.FetchAllHabits.Response())
        }
    }

    // MARK: - Lifecycle
    init(presenter: HomePresentationLogic, apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    // MARK: - Public Methods
    func fetchAllHabits(_ request: HomeModels.FetchAllHabits.Request) {
       DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let currentDate = dateFormatter.string(from: Date())
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token,
                "Date": currentDate
            ]
            
            let habitsEndpoint = APIEndpoint(path: .API.habits, method: .GET, headers: headers)
            
           self?.apiService.get(endpoint: habitsEndpoint, responseType: [HabitModel].self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let habits):
                        print("Привычки успешно получены")
                        self?.habits = habits
                        
                    case .failure(let error):
                        print("Ошибка получения привычек: \(error)")
                        self?.presenter.retryFetchHabits(HomeModels.FetchAllHabits.Response())
                    }
                }
            }
        }
    }
    
    func updateHabitExecution(_ request: HomeModels.UpdateHabitExecution.Request) {
        DispatchQueue.global().async { [weak self] in
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
            
            let body: HabitModel = request.habit
            
            self?.apiService.send(endpoint: habitsEndpoint, body: body, responseType: HomeModels.UpdateHabitResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        print(response.detail ?? "Привычка успешно обновлена")
                        request.onFinish()
                        
                    case .failure(let error):
                        print("Ошибка обновления привычки: \(error)")
                        request.onFinish()
                    }
                }
            }
        }
    }
    
    func routeToHabitExecutionScreen(_ request: HomeModels.RouteToHabitExecutionScreen.Request) {
        presenter.routeToHabitExecutionScreen(HomeModels.RouteToHabitExecutionScreen.Response(habit: request.habit, onDismiss: request.onDismiss))
    }
    
    func routeToAddHabitScreen(_ request: HomeModels.RouteToAddHabitScreen.Request) {
        presenter.routeToAddHabitScreen(HomeModels.RouteToAddHabitScreen.Response())
    }
    
    func routeToProfileScreen(_ request: HomeModels.RouteToProfileScreen.Request) {
        presenter.routeToProfileScreen(HomeModels.RouteToProfileScreen.Response())
    }
}
