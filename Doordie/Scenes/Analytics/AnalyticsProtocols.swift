//
//  AnalyticsProtocols.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import UIKit

protocol HabitsAnalyticsStorage {
    var habitsAnalytics: [HabitAnalytics] { get set }
}

protocol AnalyticsBusinessLogic {
    func fetchAllHabits(_ request: AnalyticsModels.FetchAllHabitsAnalytics.Request)
}

protocol AnalyticsPresentationLogic {
    func presentHabits(_ response: AnalyticsModels.FetchAllHabitsAnalytics.Response)
    func retryFetchHabits(_ response: AnalyticsModels.FetchAllHabitsAnalytics.Response)
}
