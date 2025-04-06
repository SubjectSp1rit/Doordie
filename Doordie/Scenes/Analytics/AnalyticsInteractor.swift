//
//  AnalyticsInteractor.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import UIKit

final class AnalyticsInteractor: AnalyticsBusinessLogic, HabitsAnalyticsStorage {
    // MARK: - Constants
    private let presenter: AnalyticsPresentationLogic
    
    // MARK: - Properties
    internal var habitsAnalytics: [AnalyticsModels.HabitAnalytics] = [] {
        didSet {
            presenter.presentHabits(AnalyticsModels.FetchAllHabitsAnalytics.Response())
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: AnalyticsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func fetchAllHabits(_ request: AnalyticsModels.FetchAllHabitsAnalytics.Request) {
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
            
            let habitsEndpoint = APIEndpoint(path: .API.habitAnalytics, method: .GET, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            apiService.get(endpoint: habitsEndpoint, responseType: AnalyticsModels.AnalyticsResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        if let message = response.detail {
                            print(message)
                        }
                        guard let habitsData = response.data else { return }
                        self?.habitsAnalytics = habitsData
                        
                    case .failure(let error):
                        print("Ошибка получения аналити по привычкам: \(error)")
                    }
                }
            }
        }
    }
}
