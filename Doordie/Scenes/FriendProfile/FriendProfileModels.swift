//
//  FriendProfileModels.swift
//  Doordie
//
//  Created by Arseniy on 05.04.2025.
//

enum FriendProfileModels {
    enum FetchAllHabitsAnalytics {
        struct Request {
            var email: String
        }
        struct Response { }
        struct ViewModel { }
    }
    
    struct AnalyticsResponse: Codable {
        var data: [HabitAnalytics]?
        var detail: String?
    }
}

