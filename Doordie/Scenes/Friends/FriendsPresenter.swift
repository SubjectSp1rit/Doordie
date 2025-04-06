//
//  FriendsPresenter.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class FriendsPresenter: FriendsPresentationLogic {
    // MARK: - Variables
    weak var view: FriendsViewController?
    
    // MARK: - Methods
    func routeToAddFriendScreen(_ response: FriendsModels.RouteToAddFriendScreen.Response) {
        let addFriendVC = AddFriendAssembly.build()
        addFriendVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(addFriendVC, animated: true)
    }
    
    func routeToFriendProfileScreen(_ response: FriendsModels.RouteToFriendProfileScreen.Response) {
        let friendProfileVC = FriendProfileAssembly.build(email: response.email, name: response.name)
        friendProfileVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(friendProfileVC, animated: true)
    }
    
    func presentAllFriends(_ response: FriendsModels.FetchAllFriends.Response) {
        view?.displayFetchedFriends(FriendsModels.FetchAllFriends.ViewModel())
    }
}
