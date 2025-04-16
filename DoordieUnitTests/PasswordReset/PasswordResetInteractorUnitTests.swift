//
//  PasswordResetUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class PasswordResetInteractorUnitTests: XCTestCase {
    var interactor: PasswordResetInteractor!
    var presenterSpy: PasswordResetPresenterSpy!
    var mockAPIService: PasswordResetMockAPIService!
    
    override func setUp() {
        super.setUp()
        presenterSpy = PasswordResetPresenterSpy()
        mockAPIService = PasswordResetMockAPIService()
        interactor = PasswordResetInteractor(presenter: presenterSpy, apiService: mockAPIService)
    }
    
    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    /// Проверяем, что метод showSentPopup вызывает соответствующий метод презентера
    /// и передаёт корректный email.
    func testShowSentPopup() {
        // Arrange:
        let email = "test@example.com"
        let request = PasswordResetModels.PresentSentPopup.Request(mail: email)
        
        // Act:
        interactor.showSentPopup(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.sentPopupCalled, "presentSentPopup должен быть вызван")
        XCTAssertEqual(presenterSpy.sentPopupResponse?.mail, email, "Почта должна передаваться корректно")
    }
    
    /// Проверяем, что метод routeToRegistrationEmailScreen вызывает метод презентера
    /// и корректно передаёт email.
    func testRouteToRegistrationEmailScreen() {
        // Arrange:
        let email = "register@example.com"
        let request = PasswordResetModels.RouteToRegistrationEmailScreen.Request(email: email)
        
        // Act:
        interactor.routeToRegistrationEmailScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.registrationEmailScreenCalled, "routeToRegistrationEmailScreen должен быть вызван")
        XCTAssertEqual(presenterSpy.registrationEmailResponse?.email, email, "Email должен передаваться корректно")
    }
    
    /// Тест проверяет сценарий успешной проверки существования почты:
    /// – эмулируется успешный ответ API с is_exists = true,
    /// – проверяется, что вызывается метод presentIfEmailExists с корректными данными.
    func testCheckEmailExistsSuccess() {
        // Arrange:
        let dummyResponse = LoginModels.IsEmailExists(is_exists: true)
        mockAPIService.sendResult = dummyResponse
        
        let email = "exists@example.com"
        let request = PasswordResetModels.CheckEmailExists.Request(email: email)
        
        let expectation = self.expectation(description: "Ожидаем вызова presentIfEmailExists")
        
        // Act:
        interactor.checkEmailExists(request)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.ifEmailExistsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.ifEmailExistsCalled, "presentIfEmailExists должен быть вызван при успешной проверке почты")
        XCTAssertEqual(presenterSpy.checkEmailExistsResponse?.isExists, true, "Флаг isExists должен быть true")
        XCTAssertEqual(presenterSpy.checkEmailExistsResponse?.email, email, "Email должен передаваться корректно")
    }
    
    /// Тест проверяет сценарий ошибки при проверке существования почты:
    /// – эмулируется ошибка API,
    /// – проверяется, что метод presentIfEmailExists не вызывается.
    func testCheckEmailExistsFailure() {
        // Arrange:
        enum TestError: Error { case apiFailure }
        mockAPIService.sendError = TestError.apiFailure
        
        let email = "fail@example.com"
        let request = PasswordResetModels.CheckEmailExists.Request(email: email)
        
        presenterSpy.ifEmailExistsCalled = false
        
        let expectation = self.expectation(description: "Ожидаем, что presentIfEmailExists НЕ будет вызван")
        expectation.isInverted = true
        
        // Act:
        interactor.checkEmailExists(request)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.ifEmailExistsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertFalse(presenterSpy.ifEmailExistsCalled, "presentIfEmailExists не должен вызываться при ошибке API")
    }
}
