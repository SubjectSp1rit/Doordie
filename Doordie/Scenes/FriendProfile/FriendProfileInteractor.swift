//
//  FriendProfileInteractor.swift
//  Doordie
//
//  Created by Arseniy on 05.04.2025.
//

import UIKit

final class FriendProfileInteractor: FriendProfileBusinessLogic, HabitsAnalyticsStorage {
    // MARK: - Constants
    private let presenter: FriendProfilePresentationLogic
    
    // MARK: - Properties
    internal var habitsAnalytics: [HabitAnalytics] = [] {
        didSet {
            presenter.presentHabits(FriendProfileModels.FetchAllHabitsAnalytics.Response())
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: FriendProfilePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func fetchAllHabits(_ request: FriendProfileModels.FetchAllHabitsAnalytics.Request) {
        DispatchQueue.global().async { [weak self] in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let currentDate = dateFormatter.string(from: Date())
            
            let friendEmail = request.email
            
            let headers = [
                "Content-Type": "application/json",
                "FriendEmail": friendEmail,
                "Date": currentDate
            ]
            
            let habitsEndpoint = APIEndpoint(path: .API.friendHabitAnalytics, method: .GET, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            apiService.get(endpoint: habitsEndpoint, responseType: FriendProfileModels.AnalyticsResponse.self) { result in
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
                        self?.presenter.retryFetchHabits(FriendProfileModels.FetchAllHabitsAnalytics.Response())
                    }
                }
            }
        }
    }
}
