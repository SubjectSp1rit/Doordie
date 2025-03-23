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
}

protocol HomePresentationLogic {
    func presentHabits(_ response: HomeModels.FetchAllHabits.Response)
}
