//
//  FriendsProtocols.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import UIKit

protocol FriendsBusinessLogic {
    func routeToFriendProfileScreen(_ request: FriendsModels.RouteToFriendProfileScreen.Request)
    func routeToAddFriendScreen(_ request: FriendsModels.RouteToAddFriendScreen.Request)
    func fetchAllFriends(_ request: FriendsModels.FetchAllFriends.Request)
    func deleteFriend(_ request: FriendsModels.DeleteFriend.Request)
}

protocol FriendsPresentationLogic {
    func routeToFriendProfileScreen(_ response: FriendsModels.RouteToFriendProfileScreen.Response)
    func routeToAddFriendScreen(_ response: FriendsModels.RouteToAddFriendScreen.Response)
    func presentAllFriends(_ response: FriendsModels.FetchAllFriends.Response)
}
