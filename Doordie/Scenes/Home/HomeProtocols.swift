//
//  HomeProtocols.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

protocol HabitsStorage {
    var habits: [Habit] { get set }
}

protocol HomeBusinessLogic {
    func loadHabits(_ request: HomeModels.LoadHabits.Request)
}

protocol HomePresentationLogic {
    func presentHabits(_ response: HomeModels.LoadHabits.Response)
}
