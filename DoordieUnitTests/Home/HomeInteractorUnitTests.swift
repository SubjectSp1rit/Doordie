//
//  HomeUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 08.04.2025.
//

import XCTest
@testable import Doordie

final class HomeInteractorUnitTests: XCTestCase {
    // MARK: - Properties
    var interactor: HomeInteractor!
    var mockPresenter: MockHomePresenter!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        mockPresenter = MockHomePresenter()
        interactor = HomeInteractor(presenter: mockPresenter)
    }
    
    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testPresenterCalledWhenHabitsSet() {
        // Arrange
        let dummyHabit = HabitModel(
            id: 1,
            creationDate: Date(),
            title: "Test Habit",
            motivations: nil,
            color: nil,
            icon: nil,
            quantity: "1",
            currentQuantity: "1",
            measurement: nil,
            regularity: nil,
            dayPart: "All day"
        )
        
        // Act
        interactor.habits = [dummyHabit]
        
        // Assert
        XCTAssertTrue(mockPresenter.presentHabitsCalled, "presentHabits должен быть вызван при установке привычек")
    }
    
    func testRetryFetchHabitsCalledOnError() {
        // Arrange
        let response = HomeModels.FetchAllHabits.Response()
        
        // Act
        mockPresenter.retryFetchHabits(response)
        
        // Assert
        XCTAssertTrue(mockPresenter.retryFetchHabitsCalled, "retryFetchHabits должен быть вызван при ошибке получения привычек")
    }
    
    func testRouteToHabitExecutionScreen() {
        // Arrange
        let dummyHabit = HabitModel(
            id: 1,
            creationDate: Date(),
            title: "Test Habit",
            motivations: nil,
            color: nil,
            icon: nil,
            quantity: "1",
            currentQuantity: "1",
            measurement: nil,
            regularity: nil,
            dayPart: "All day"
        )
        let request = HomeModels.RouteToHabitExecutionScreen.Request(
            habit: dummyHabit,
            onDismiss: { }
        )
        
        // Act
        interactor.routeToHabitExecutionScreen(request)
        
        // Assert
        XCTAssertTrue(mockPresenter.routeToHabitExecutionScreenCalled, "routeToHabitExecutionScreen должен вызывать соответствующий метод презентера")
    }
    
    func testRouteToAddHabitScreen() {
        // Arrange
        let request = HomeModels.RouteToAddHabitScreen.Request()
        
        // Act
        interactor.routeToAddHabitScreen(request)
        
        // Assert
        XCTAssertTrue(mockPresenter.routeToAddHabitScreenCalled, "routeToAddHabitScreen должен вызывать соответствующий метод презентера")
    }
    
    func testRouteToProfileScreen() {
        // Arrange
        let request = HomeModels.RouteToProfileScreen.Request()
        
        // Act
        interactor.routeToProfileScreen(request)
        
        // Assert
        XCTAssertTrue(mockPresenter.routeToProfileScreenCalled, "routeToProfileScreen должен вызывать соответствующий метод презентера")
    }
}
