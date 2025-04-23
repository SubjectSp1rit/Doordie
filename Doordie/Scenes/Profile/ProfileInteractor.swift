//
//  ProfileInteractor.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

final class ProfileInteractor: ProfileBusinessLogic, FriendsStorage, HabitsAnalyticsStorage {
    // MARK: - Constants
    private let presenter: ProfilePresentationLogic
    private let apiService: APIServiceProtocol
    
    // MARK: - Properties
    internal var friends: [FriendUser] = [] {
        didSet {
            presenter.presentAllFriends(ProfileModels.FetchAllFriends.Response())
        }
    }
    
    internal var habitsAnalytics: [HabitAnalytics] = [] {
        didSet {
            presenter.presentHabits(ProfileModels.FetchAllHabitsAnalytics.Response())
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: ProfilePresentationLogic, apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    // MARK: - Methods
    func routeToAddFriendScreen(_ request: ProfileModels.RouteToAddFriendScreen.Request) {
        presenter.routeToAddFriendScreen(ProfileModels.RouteToAddFriendScreen.Response())
    }
    
    func routeToFriendProfileScreen(_ request: ProfileModels.RouteToFriendProfileScreen.Request) {
        presenter.routeToFriendProfileScreen(ProfileModels.RouteToFriendProfileScreen.Response(email: request.email, name: request.name))
    }
    
    func fetchAllFriends(_ request: ProfileModels.FetchAllFriends.Request) {
        DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let friendsEndpoint = APIEndpoint(path: .API.friends, method: .GET, headers: headers)
            
            self?.apiService.get(endpoint: friendsEndpoint, responseType: ProfileModels.GetFriendsResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        if let message = response.detail {
                            print(message)
                        }
                        guard let friends = response.friends else { return }
                        self?.friends = friends
                        
                    case .failure(let error):
                        print("Error while loading friends: \(error)")
                        self?.presenter.retryFetachAllFriends(ProfileModels.FetchAllFriends.Response())
                    }
                }
            }
        }
    }
    
    func fetchAllHabits(_ request: ProfileModels.FetchAllHabitsAnalytics.Request) {
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
            
            apiService.get(endpoint: habitsEndpoint, responseType: ProfileModels.AnalyticsResponse.self) { result in
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
                        self?.presenter.retryFetchHabits(ProfileModels.FetchAllHabitsAnalytics.Response())
                    }
                }
            }
        }
    }
    
    func deleteFriend(_ request: ProfileModels.DeleteFriend.Request) {
        DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let friendsEndpoint = APIEndpoint(path: .API.friends, method: .DELETE, headers: headers)
            
            let body = ProfileModels.Email(email: request.email)
            
            self?.apiService.send(endpoint: friendsEndpoint, body: body, responseType: ProfileModels.DeleteFriendResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        if let message = response.detail {
                            print(message)
                        }
                        
                    case .failure(let error):
                        print("Error while deleting friend: \(error)")
                    }
                }
            }
        }
    }
}
