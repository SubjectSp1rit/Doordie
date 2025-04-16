//
//  AddHabitMockPresenter.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 10.04.2025.
//

import XCTest
@testable import Doordie

class AddHabitMockPresenter: AddHabitPresentationLogic {
    var presentUpdatedCalled = false
    var presentCreatedCalled = false
    var expectation: XCTestExpectation?
    
    func presentUpdatedHabit(_ response: AddHabitModels.UpdateHabit.Response) {
        presentUpdatedCalled = true
        expectation?.fulfill()
    }
    
    func presentHabitsAfterCreating(_ response: AddHabitModels.CreateHabit.Response) {
        presentCreatedCalled = true
        expectation?.fulfill()
    }
}
