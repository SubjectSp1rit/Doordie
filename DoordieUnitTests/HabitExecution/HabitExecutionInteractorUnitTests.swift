//
//  HabitExecutionUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class HabitExecutionInteractorUnitTests: XCTestCase {
    var interactor: HabitExecutionInteractor!
    var presenterSpy: HabitExecutionPresenterSpy!
    var mockAPIService: HabitExecutionMockAPIService!
    
    var dummyHabit: HabitModel!
    
    override func setUp() {
        super.setUp()
        // Arrange
        UserDefaultsManager.shared.authToken = "testToken"
        presenterSpy = HabitExecutionPresenterSpy()
        mockAPIService = HabitExecutionMockAPIService()
        interactor = HabitExecutionInteractor(presenter: presenterSpy, apiService: mockAPIService)
        
        dummyHabit = HabitModel(
            creationDate: Date(),
            title: "Test Habit",
            motivations: "Test",
            color: "FFFFFF",
            icon: "testIcon",
            quantity: "60",
            currentQuantity: "0",
            measurement: "Mins",
            regularity: "Every Day",
            dayPart: "Morning"
        )
    }
    
    override func tearDown() {
        UserDefaultsManager.shared.authToken = nil
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        dummyHabit = nil
        super.tearDown()
    }
    
    func testShowDeleteConfirmationMessage() {
        // Arrange
        let request = HabitExecutionModels.ShowDeleteConfirmationMessage.Request(habit: dummyHabit)
        
        // Act
        interactor.showDeleteConfirmationMessage(request)
        
        // Assert
        XCTAssertTrue(presenterSpy.presentDeleteConfirmationMessageCalled, "presentDeleteConfirmationMessage должен быть вызван")
        XCTAssertEqual(presenterSpy.deleteConfirmationHabit?.title, dummyHabit.title, "Объект привычки должен передаваться корректно")
    }
    
    func testShowEditHabitScreen() {
        // Arrange
        let request = HabitExecutionModels.ShowEditHabitScreen.Request(habit: dummyHabit)
        
        // Act
        interactor.showEditHabitScreen(request)
        
        // Assert
        XCTAssertTrue(presenterSpy.presentEditHabitScreenCalled, "presentEditHabitScreen должен быть вызван")
        XCTAssertEqual(presenterSpy.editHabit?.title, dummyHabit.title, "Объект привычки должен передаваться корректно")
    }
    
    func testDeleteHabitSuccess() {
        // Arrange
        let successDetail = "Привычка удалена успешно"
        let dummyResponse = HabitExecutionModels.DeleteHabitResponse(detail: successDetail)
        mockAPIService.sendResult = dummyResponse
        
        let request = HabitExecutionModels.DeleteHabit.Request(habit: dummyHabit)
        let expectation = self.expectation(description: "Ожидаем вызова presentHabitsAfterDeleting")
        
        // Act
        interactor.deleteHabit(request)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            if self.presenterSpy.presentHabitsAfterDeletingCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(presenterSpy.presentHabitsAfterDeletingCalled, "presentHabitsAfterDeleting должен быть вызван при успешном удалении привычки")
    }
    
    func testDeleteHabitFailure() {
        // Arrange
        enum TestError: Error { case deleteFailed }
        mockAPIService.sendError = TestError.deleteFailed
        
        let request = HabitExecutionModels.DeleteHabit.Request(habit: dummyHabit)
        presenterSpy.presentHabitsAfterDeletingCalled = false
        
        // Act
        interactor.deleteHabit(request)
        
        let expectation = self.expectation(description: "Ожидаем завершения deleteHabit с ошибкой")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert
        XCTAssertFalse(presenterSpy.presentHabitsAfterDeletingCalled, "presentHabitsAfterDeleting не должен быть вызван при ошибке удаления привычки")
    }
    
    func testUpdateHabitExecutionSuccess() {
        // Arrange
        let successDetail = "Привычка успешно обновлена"
        let dummyResponse = HabitExecutionModels.UpdateHabitResponse(detail: successDetail)
        mockAPIService.sendResult = dummyResponse
        
        let expectation = self.expectation(description: "Ожидаем вызова onDismiss при успешном обновлении привычки")
        var onDismissCalled = false
        
        let request = HabitExecutionModels.UpdateHabitExecution.Request(habit: dummyHabit) {
            onDismissCalled = true
            expectation.fulfill()
        }
        
        // Act
        interactor.updateHabitExecution(request)
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert
        XCTAssertTrue(onDismissCalled, "onDismiss должен быть вызван при успешном обновлении привычки")
    }
    
    func testUpdateHabitExecutionFailure() {
        // Arrange
        enum TestError: Error { case updateFailed }
        mockAPIService.sendError = TestError.updateFailed
        
        let expectation = self.expectation(description: "Ожидаем вызова onDismiss при ошибке обновления привычки")
        var onDismissCalled = false
        
        let request = HabitExecutionModels.UpdateHabitExecution.Request(habit: dummyHabit) {
            onDismissCalled = true
            expectation.fulfill()
        }
        
        // Act
        interactor.updateHabitExecution(request)
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert
        XCTAssertTrue(onDismissCalled, "onDismiss должен быть вызван даже при ошибке обновления привычки")
    }
}
