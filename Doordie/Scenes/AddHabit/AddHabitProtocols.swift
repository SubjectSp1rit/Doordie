//
//  AddHabitProtocols.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

protocol AddHabitBusinessLogic {
    func updateHabit(_ request: AddHabitModels.UpdateHabit.Request)
    func createHabit(_ request: AddHabitModels.CreateHabit.Request)
}

protocol AddHabitPresentationLogic {
    func presentUpdatedHabit(_ response: AddHabitModels.UpdateHabit.Response)
    func presentHabitsAfterCreating(_ response: AddHabitModels.CreateHabit.Response)
}
