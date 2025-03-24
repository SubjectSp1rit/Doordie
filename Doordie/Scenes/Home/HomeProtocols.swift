//
//  HomeProtocols.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

protocol HabitsStorage {
    var habits: [HabitModel] { get set }
}

protocol HomeBusinessLogic {
    func fetchAllHabits(_ request: HomeModels.FetchAllHabits.Request)
    func routeToHabitExecutionScreen(_ request: HomeModels.RouteToHabitExecutionScreen.Request)
    func routeToAddHabitScreen(_ request: HomeModels.RouteToAddHabitScreen.Request)
}

protocol HomePresentationLogic {
    func presentHabits(_ response: HomeModels.FetchAllHabits.Response)
    func routeToHabitExecutionScreen(_ response: HomeModels.RouteToHabitExecutionScreen.Response)
    func routeToAddHabitScreen(_ response: HomeModels.RouteToAddHabitScreen.Response)
}
