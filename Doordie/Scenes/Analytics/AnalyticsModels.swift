//
//  AnalyticsModels.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum AnalyticsModels {
    enum FetchAllHabitsAnalytics {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    struct AnalyticsResponse: Codable {
        var data: [HabitAnalytics]?
        var detail: String?
    }
    
    struct HabitAnalytics: Codable {
        var id: Int?
        var title: String?
        var color: String?
        var icon: String?
        var executions: [HabitExecution]
    }
    
    struct HabitExecution: Codable {
        var execution_date: String?
    }
}

