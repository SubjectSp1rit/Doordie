//
//  AddHabitInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 10.04.2025.
//

import XCTest
@testable import Doordie

// MARK: - Тесты AddHabitInteractor

final class AddHabitInteractorUnitTests: XCTestCase {
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        URLProtocol.registerClass(AddHabitURLProtocolStub.self)
    }
    
    override func tearDown() {
        URLProtocol.unregisterClass(AddHabitURLProtocolStub.self)
        AddHabitURLProtocolStub.stubResponseData = nil
        AddHabitURLProtocolStub.stubError = nil
        UserDefaultsManager.shared.authToken = nil
        super.tearDown()
    }
    
    // MARK: - Private Methods
    private func makeDummyHabit() -> HabitModel {
        return HabitModel(
            id: 1,
            creationDate: Date(),
            title: "Тестовая привычка",
            motivations: "Мотивация",
            color: "FFFFFF",
            icon: "star",
            quantity: "30",
            currentQuantity: "0",
            measurement: "Мин",
            regularity: "Каждый день",
            dayPart: "В любое время"
        )
    }
    
    // MARK: - Tests
    func testUpdateHabitFailure() {
        // Arrange
        // ждем, что презентер не будет вызван при ошибке обновления привычки.
        let exp = expectation(description: "Презентер не должен быть вызван при ошибке обновления привычки")
        exp.isInverted = true
        
        let mockPresenter = AddHabitMockPresenter()
        let mockAPIService = AddHabitMockAPIService()
        let error = NSError(domain: "Test", code: 0, userInfo: nil)
        mockAPIService.resultToReturn = .failure(error)
        
        UserDefaultsManager.shared.authToken = "тестовый-токен"
        let interactor = AddHabitInteractor(presenter: mockPresenter, apiService: mockAPIService)
        let dummyHabit = makeDummyHabit()
        let request = AddHabitModels.UpdateHabit.Request(habit: dummyHabit)
        
        // Act
        interactor.updateHabit(request)
        
        // Assert
        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(mockAPIService.sendCalled, "Метод APIService.send должен быть вызван даже при ошибке обновления привычки")
            XCTAssertFalse(mockPresenter.presentUpdatedCalled, "Презентер не должен вызываться при ошибке обновления привычки")
        }
    }
    
    func testUpdateHabitWithoutToken() {
        // Arrange
        let mockPresenter = AddHabitMockPresenter()
        let mockAPIService = AddHabitMockAPIService()
        UserDefaultsManager.shared.authToken = nil
        let interactor = AddHabitInteractor(presenter: mockPresenter, apiService: mockAPIService)
        let dummyHabit = makeDummyHabit()
        let request = AddHabitModels.UpdateHabit.Request(habit: dummyHabit)
        
        // Act
        interactor.updateHabit(request)
        
        let exp = expectation(description: "Метод APIService.send не должен вызываться без токена")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            exp.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 1) { _ in
            XCTAssertFalse(mockAPIService.sendCalled, "Метод APIService.send не должен вызываться без токена")
            XCTAssertFalse(mockPresenter.presentUpdatedCalled, "Презентер не должен вызываться без токена")
        }
    }
    
    func testCreateHabitFailure() {
        // Arrange
        // Ждем, что презентер НЕ будет вызван при ошибке создания привычки.
        let exp = expectation(description: "Презентер не должен быть вызван при ошибке создания привычки")
        exp.isInverted = true
        let mockPresenter = AddHabitMockPresenter()
        let dummyHabit = makeDummyHabit()
        let request = AddHabitModels.CreateHabit.Request(habit: dummyHabit)
        UserDefaultsManager.shared.authToken = "тестовый-токен"
        
        AddHabitURLProtocolStub.stubError = NSError(domain: "Test", code: 0, userInfo: nil)
        
        let interactor = AddHabitInteractor(presenter: mockPresenter, apiService: AddHabitMockAPIService())
        
        // Act
        interactor.createHabit(request)
        
        // Assert
        waitForExpectations(timeout: 1) { _ in
            XCTAssertFalse(mockPresenter.presentCreatedCalled, "Презентер не должен вызываться при ошибке создания привычки")
        }
    }
    
    func testCreateHabitWithoutToken() {
        // Arrange
        let mockPresenter = AddHabitMockPresenter()
        let dummyHabit = makeDummyHabit()
        let request = AddHabitModels.CreateHabit.Request(habit: dummyHabit)
        UserDefaultsManager.shared.authToken = nil
        
        let interactor = AddHabitInteractor(presenter: mockPresenter, apiService: AddHabitMockAPIService())
        
        // Act
        interactor.createHabit(request)
        
        let exp = expectation(description: "API запрос для createHabit не должен выполняться без токена")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            exp.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 1) { _ in
            XCTAssertFalse(mockPresenter.presentCreatedCalled, "Презентер не должен быть вызван, если токен отсутствует")
        }
    }
}

