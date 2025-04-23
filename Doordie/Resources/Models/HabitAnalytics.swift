//
//  HabitAnalytics.swift
//  Doordie
//
//  Created by Arseniy on 23.04.2025.
//

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
