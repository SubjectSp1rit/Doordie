//
//  APIPaths.swift
//  Doordie
//
//  Created by Arseniy on 30.03.2025.
//

internal extension String {
    enum API {
        static let baseURL = "http://localhost:8000"
        
        static let habitAnalytics = "/habit_analytics"
        static let friendHabitAnalytics = "/friend_habit_analytics"
        static let habits = "/habits"
        static let habitExecution = "/habit_execution"
        static let friends = "/friends"
        static let sendEmail = "/send_email"
        static let login = "/login"
        static let emails = "/emails"
        static let register = "/register"
    }
}
