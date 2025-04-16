//
//  ProfilePresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class ProfilePresenterSpy: ProfilePresentationLogic {
    var addFriendScreenCalled = false
    var friendProfileScreenCalled = false
    var presentAllFriendsCalled = false
    var retryFetchAllFriendsCalled = false
    
    var friendProfileResponse: ProfileModels.RouteToFriendProfileScreen.Response?
    
    func routeToAddFriendScreen(_ response: ProfileModels.RouteToAddFriendScreen.Response) {
        addFriendScreenCalled = true
    }
    
    func routeToFriendProfileScreen(_ response: ProfileModels.RouteToFriendProfileScreen.Response) {
        friendProfileScreenCalled = true
        friendProfileResponse = response
    }
    
    func presentAllFriends(_ response: ProfileModels.FetchAllFriends.Response) {
        presentAllFriendsCalled = true
    }
    
    func retryFetachAllFriends(_ response: ProfileModels.FetchAllFriends.Response) {
        retryFetchAllFriendsCalled = true
    }
}
