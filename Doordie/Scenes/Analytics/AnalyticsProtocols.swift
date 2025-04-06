//
//  AnalyticsProtocols.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import UIKit

protocol HabitsAnalyticsStorage {
    var habitsAnalytics: [AnalyticsModels.HabitAnalytics] { get set }
}

protocol AnalyticsBusinessLogic {
    func fetchAllHabits(_ request: AnalyticsModels.FetchAllHabitsAnalytics.Request)
}

protocol AnalyticsPresentationLogic {
    func presentHabits(_ response: AnalyticsModels.FetchAllHabitsAnalytics.Response)
}
