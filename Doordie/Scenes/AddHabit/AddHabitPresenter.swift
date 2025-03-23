//
//  AddHabitPresenter.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class AddHabitPresenter: AddHabitPresentationLogic {
    // MARK: - Variables
    weak var view: AddHabitViewController?
    
    // MARK: - Methods
    func presentUpdatedHabit(_ response: AddHabitModels.UpdateHabit.Response) {
        view?.displayUpdatedHabit(AddHabitModels.UpdateHabit.ViewModel())
    }
}
