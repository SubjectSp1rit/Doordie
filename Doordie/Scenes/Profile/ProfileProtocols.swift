//
//  ProfileProtocols.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

protocol FriendsStorage {
    var friends: [ProfileModels.FriendUser] { get set }
}

protocol ProfileBusinessLogic {
    func routeToAddFriendScreen(_ request: ProfileModels.RouteToAddFriendScreen.Request)
    func fetchAllFriends(_ request: ProfileModels.FetchAllFriends.Request)
    func deleteFriend(_ request: ProfileModels.DeleteFriend.Request)
}

protocol ProfilePresentationLogic {
    func routeToAddFriendScreen(_ response: ProfileModels.RouteToAddFriendScreen.Response)
    func presentAllFriends(_ response: ProfileModels.FetchAllFriends.Response)
}
