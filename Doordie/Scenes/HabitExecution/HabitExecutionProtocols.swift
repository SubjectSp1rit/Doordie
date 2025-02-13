//
//  HabitExecutionProtocols.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

protocol HabitExecutionBusinessLogic {
    func showDeleteConfirmationMessage(_ request: HabitExecutionModels.ShowDeleteConfirmationMessage.Request)
    func showEditHabitScreen(_ request: HabitExecutionModels.ShowEditHabitScreen.Request)
}

protocol HabitExecutionPresentationLogic {
    func presentDeleteConfirmationMessage(_ response: HabitExecutionModels.ShowDeleteConfirmationMessage.Response)
    func presentEditHabitScreen(_ response: HabitExecutionModels.ShowEditHabitScreen.Response)
}
