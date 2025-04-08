//
//  MockHomePresenter.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 08.04.2025.
//

import XCTest
@testable import Doordie

class MockHomePresenter: HomePresentationLogic {
    var presentHabitsCalled = false
    var retryFetchHabitsCalled = false
    var routeToHabitExecutionScreenCalled = false
    var routeToAddHabitScreenCalled = false
    var routeToProfileScreenCalled = false
    
    func presentHabits(_ response: HomeModels.FetchAllHabits.Response) {
        presentHabitsCalled = true
    }
    
    func retryFetchHabits(_ response: HomeModels.FetchAllHabits.Response) {
        retryFetchHabitsCalled = true
    }
    
    func routeToHabitExecutionScreen(_ response: HomeModels.RouteToHabitExecutionScreen.Response) {
        routeToHabitExecutionScreenCalled = true
    }
    
    func routeToAddHabitScreen(_ response: HomeModels.RouteToAddHabitScreen.Response) {
        routeToAddHabitScreenCalled = true
    }
    
    func routeToProfileScreen(_ response: HomeModels.RouteToProfileScreen.Response) {
        routeToProfileScreenCalled = true
    }
}
