//
//  HabitExecutionPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class HabitExecutionPresenterSpy: HabitExecutionPresentationLogic {
    var presentDeleteConfirmationMessageCalled = false
    var presentEditHabitScreenCalled = false
    var presentHabitsAfterDeletingCalled = false
    
    var deleteConfirmationHabit: HabitModel?
    var editHabit: HabitModel?
    
    func presentDeleteConfirmationMessage(_ response: HabitExecutionModels.ShowDeleteConfirmationMessage.Response) {
        presentDeleteConfirmationMessageCalled = true
        deleteConfirmationHabit = response.habit
    }
    
    func presentEditHabitScreen(_ response: HabitExecutionModels.ShowEditHabitScreen.Response) {
        presentEditHabitScreenCalled = true
        editHabit = response.habit
    }
    
    func presentHabitsAfterDeleting(_ response: HabitExecutionModels.DeleteHabit.Response) {
        presentHabitsAfterDeletingCalled = true
    }
}
