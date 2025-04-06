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
    
    struct AnalyticsResponse: Decodable {
        var data: [HabitAnalytics]?
        var detail: String?
    }
    
    struct HabitAnalytics: Decodable {
        var id: Int?
        var title: String?
        var color: String?
        var icon: String?
        var executions: [HabitExecution]
    }
    
    struct HabitExecution: Decodable {
        var execution_date: String?
    }
}

