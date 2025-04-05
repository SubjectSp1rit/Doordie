//
//  ProfileInteractor.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

final class ProfileInteractor: ProfileBusinessLogic, FriendsStorage {
    // MARK: - Constants
    private let presenter: ProfilePresentationLogic
    
    // MARK: - Properties
    internal var friends: [ProfileModels.FriendUser] = [] {
        didSet {
            presenter.presentAllFriends(ProfileModels.FetchAllFriends.Response())
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: ProfilePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func routeToAddFriendScreen(_ request: ProfileModels.RouteToAddFriendScreen.Request) {
        presenter.routeToAddFriendScreen(ProfileModels.RouteToAddFriendScreen.Response())
    }
    
    func fetchAllFriends(_ request: ProfileModels.FetchAllFriends.Request) {
        DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let emailEndpoint = APIEndpoint(path: .API.friends, method: .GET, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            apiService.get(endpoint: emailEndpoint, responseType: ProfileModels.GetFriendsResponse.self) { result in
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
                    }
                }
            }
        }
    }
}
