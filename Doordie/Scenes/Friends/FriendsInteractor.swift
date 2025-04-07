//
//  FriendsInteractor.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class FriendsInteractor: FriendsBusinessLogic, FriendsStorage {
    // MARK: - Constants
    private let presenter: FriendsPresentationLogic
    
    // MARK: - Properties
    internal var friends: [FriendUser] = [] {
        didSet {
            presenter.presentAllFriends(FriendsModels.FetchAllFriends.Response())
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: FriendsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func routeToAddFriendScreen(_ request: FriendsModels.RouteToAddFriendScreen.Request) {
        presenter.routeToAddFriendScreen(FriendsModels.RouteToAddFriendScreen.Response())
    }
    
    func routeToFriendProfileScreen(_ request: FriendsModels.RouteToFriendProfileScreen.Request) {
        presenter.routeToFriendProfileScreen(FriendsModels.RouteToFriendProfileScreen.Response(email: request.email, name: request.name))
    }
    
    func fetchAllFriends(_ request: FriendsModels.FetchAllFriends.Request) {
        DispatchQueue.global().async { [weak self] in
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let friendsEndpoint = APIEndpoint(path: .API.friends, method: .GET, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            apiService.get(endpoint: friendsEndpoint, responseType: ProfileModels.GetFriendsResponse.self) { result in
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
                        self?.presenter.retryFetchAllFriends(FriendsModels.FetchAllFriends.Response())
                    }
                }
            }
        }
    }
    
    func deleteFriend(_ request: FriendsModels.DeleteFriend.Request) {
        DispatchQueue.global().async {
            guard let token = UserDefaultsManager.shared.authToken else { return }
            
            let headers = [
                "Content-Type": "application/json",
                "Token": token
            ]
            
            let friendsEndpoint = APIEndpoint(path: .API.friends, method: .DELETE, headers: headers)
            
            let apiService: APIServiceProtocol = APIService(baseURL: .API.baseURL)
            
            let body = FriendsModels.Email(email: request.email)
            
            apiService.send(endpoint: friendsEndpoint, body: body, responseType: FriendsModels.DeleteFriendResponse.self) { result in
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
