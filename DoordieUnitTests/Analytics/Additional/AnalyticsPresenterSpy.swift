//
//  AnalyticsPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class AnalyticsPresenterSpy: AnalyticsPresentationLogic {
    var presentHabitsCalled = false
    var retryFetchHabitsCalled = false
    
    func presentHabits(_ response: AnalyticsModels.FetchAllHabitsAnalytics.Response) {
        presentHabitsCalled = true
    }
    
    func retryFetchHabits(_ response: AnalyticsModels.FetchAllHabitsAnalytics.Response) {
        retryFetchHabitsCalled = true
    }
}
