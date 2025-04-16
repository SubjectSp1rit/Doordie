//
//  FriendsPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class FriendsPresenterSpy: FriendsPresentationLogic {
    var routeToAddFriendScreenCalled = false
    var routeToFriendProfileScreenCalled = false
    var presentAllFriendsCalled = false
    var retryFetchAllFriendsCalled = false
    
    var friendProfileResponse: FriendsModels.RouteToFriendProfileScreen.Response?
    
    func routeToAddFriendScreen(_ response: FriendsModels.RouteToAddFriendScreen.Response) {
        routeToAddFriendScreenCalled = true
    }
    
    func routeToFriendProfileScreen(_ response: FriendsModels.RouteToFriendProfileScreen.Response) {
        routeToFriendProfileScreenCalled = true
        friendProfileResponse = response
    }
    
    func presentAllFriends(_ response: FriendsModels.FetchAllFriends.Response) {
        presentAllFriendsCalled = true
    }
    
    func retryFetchAllFriends(_ response: FriendsModels.FetchAllFriends.Response) {
        retryFetchAllFriendsCalled = true
    }
}
