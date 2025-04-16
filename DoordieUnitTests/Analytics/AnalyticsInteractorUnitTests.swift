//
//  AnalyticsInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class AnalyticsInteractorUnitTests: XCTestCase {
    var interactor: AnalyticsInteractor!
    var presenterSpy: AnalyticsPresenterSpy!
    
    override func setUp() {
        super.setUp()
        UserDefaultsManager.shared.authToken = "dummy-token"
        presenterSpy = AnalyticsPresenterSpy()
        interactor = AnalyticsInteractor(presenter: presenterSpy)
        
        URLProtocol.registerClass(AnalyticsURLProtocolStub.self)
    }
    
    override func tearDown() {
        URLProtocol.unregisterClass(AnalyticsURLProtocolStub.self)
        interactor = nil
        presenterSpy = nil
        UserDefaultsManager.shared.clearAuthToken()
        AnalyticsURLProtocolStub.requestHandler = nil
        super.tearDown()
    }
    
    func testFetchAllHabitsSuccess() {
        // Arrange
        let dummyHabit = AnalyticsModels.HabitAnalytics(
            id: 1,
            title: "Тестовая привычка",
            color: "Red",
            icon: "star",
            executions: [AnalyticsModels.HabitExecution(execution_date: "01.01.2025")]
        )
        
        let dummyResponse = AnalyticsModels.AnalyticsResponse(data: [dummyHabit], detail: "Успешно")
        
        
        let responseData: Data
        do {
            responseData = try JSONEncoder().encode(dummyResponse)
        } catch {
            XCTFail("Ошибка кодирования фиктивного ответа")
            return
        }
        
        AnalyticsURLProtocolStub.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, responseData)
        }
        
        let expectation = self.expectation(description: "Ожидаем вызова presentHabits")
        
        // Act:
        interactor.fetchAllHabits(AnalyticsModels.FetchAllHabitsAnalytics.Request())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            if self.presenterSpy.presentHabitsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(presenterSpy.presentHabitsCalled, "presentHabits должен был вызваться при успешном ответе API")
        XCTAssertEqual(interactor.habitsAnalytics.count, 1, "Должен быть сохранён один элемент аналитики привычек")
    }
    
    func testFetchAllHabitsFailure() {
        // Arrange
        enum TestError: Error { case someError }
        
        AnalyticsURLProtocolStub.requestHandler = { request in
            throw TestError.someError
        }
        
        let expectation = self.expectation(description: "Ожидаем вызова retryFetchHabits")
        
        // Act
        interactor.fetchAllHabits(AnalyticsModels.FetchAllHabitsAnalytics.Request())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            if self.presenterSpy.retryFetchHabitsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(presenterSpy.retryFetchHabitsCalled, "retryFetchHabits должен был вызваться при ошибке API")
    }
}
