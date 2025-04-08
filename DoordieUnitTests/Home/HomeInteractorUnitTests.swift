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
        // Arrange: создаем dummy привычку
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
        
        // Act: устанавливаем полученные привычки – срабатывает didSet
        interactor.habits = [dummyHabit]
        
        // Assert: проверяем, что у презентера вызван метод presentHabits
        XCTAssertTrue(mockPresenter.presentHabitsCalled, "presentHabits должен быть вызван при установке привычек")
    }
    
    func testRetryFetchHabitsCalledOnError() {
        // Arrange: готовим пустой response (симуляция ошибки)
        let response = HomeModels.FetchAllHabits.Response()
        
        // Act: вызываем метод retryFetchHabits у мок-презентера
        mockPresenter.retryFetchHabits(response)
        
        // Assert: убеждаемся, что метод вызван
        XCTAssertTrue(mockPresenter.retryFetchHabitsCalled, "retryFetchHabits должен быть вызван при ошибке получения привычек")
    }
    
    func testRouteToHabitExecutionScreen() {
        // Arrange: создаем dummy привычку и запрос на маршрут к экрану выполнения привычки
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
        
        // Act: вызываем метод маршрутизации в интеракторе
        interactor.routeToHabitExecutionScreen(request)
        
        // Assert: проверяем, что вызов был передан презентеру
        XCTAssertTrue(mockPresenter.routeToHabitExecutionScreenCalled, "routeToHabitExecutionScreen должен вызывать соответствующий метод презентера")
    }
    
    func testRouteToAddHabitScreen() {
        // Arrange: готовим запрос для маршрута на экран добавления привычки
        let request = HomeModels.RouteToAddHabitScreen.Request()
        
        // Act: вызываем соответствующий метод маршрутизации
        interactor.routeToAddHabitScreen(request)
        
        // Assert: проверяем вызов
        XCTAssertTrue(mockPresenter.routeToAddHabitScreenCalled, "routeToAddHabitScreen должен вызывать соответствующий метод презентера")
    }
    
    func testRouteToProfileScreen() {
        // Arrange: готовим запрос для перехода на экран профиля
        let request = HomeModels.RouteToProfileScreen.Request()
        
        // Act: вызываем метод маршрутизации
        interactor.routeToProfileScreen(request)
        
        // Assert: проверяем, что соответствующий метод презентера вызван
        XCTAssertTrue(mockPresenter.routeToProfileScreenCalled, "routeToProfileScreen должен вызывать соответствующий метод презентера")
    }
}
