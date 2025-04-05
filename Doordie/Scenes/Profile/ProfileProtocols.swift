//
//  ProfileProtocols.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

protocol ProfileBusinessLogic {
    func routeToAddFriendScreen(_ request: ProfileModels.RouteToAddFriendScreen.Request)
}

protocol ProfilePresentationLogic {
    func routeToAddFriendScreen(_ response: ProfileModels.RouteToAddFriendScreen.Response)
}
