//
//  APIPaths.swift
//  Doordie
//
//  Created by Arseniy on 30.03.2025.
//

internal extension String {
    enum API {
        static let baseURL = "http://localhost:8000"
        
        static let habits = "/habits"
        static let habitExecution = "/habit_execution"
        static let friends = "/friends"
        static let login = "/login"
        static let emails = "/emails"
        static let register = "/register"
    }
}
