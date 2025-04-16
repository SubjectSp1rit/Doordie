//
//  RegistrationEmailInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationEmailInteractorUnitTests: XCTestCase {
    var interactor: RegistrationEmailInteractor!
    var presenterSpy: RegistrationEmailPresenterSpy!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        presenterSpy = RegistrationEmailPresenterSpy()
        mockAPIService = MockAPIService()
        interactor = RegistrationEmailInteractor(presenter: presenterSpy, apiService: mockAPIService)
    }
    
    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    /// Тест проверяет, что метод routeToRegistrationEmailCodeScreen вызывает соответствующий метод презентера
    /// с корректно переданным email.
    func testRouteToRegistrationEmailCodeScreen() {
        // Arrange:
        let email = "user@example.com"
        let request = RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Request(email: email)
        
        // Act:
        interactor.routeToRegistrationEmailCodeScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.codeScreenCalled, "Метод routeToRegistrationEmailCodeScreen должен быть вызван")
        XCTAssertEqual(presenterSpy.routeToCodeResponse?.email, email, "Email должен передаваться корректно")
    }
    
    /// Тест проверяет, что метод routeToLoginScreen вызывает соответствующий метод презентера
    /// и передаёт email.
    func testRouteToLoginScreen() {
        // Arrange:
        let email = "user@example.com"
        let request = RegistrationEmailModels.RouteToLoginScreen.Request(email: email)
        
        // Act:
        interactor.routeToLoginScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.loginScreenCalled, "Метод routeToLoginScreen должен быть вызван")
        XCTAssertEqual(presenterSpy.routeToLoginResponse?.email, email, "Email должен передаваться корректно")
    }
    
    /// Тест проверяет успешную проверку существования почты:
    /// – эмулируется успешный ответ API с флагом is_exists = true;
    /// – проверяется, что вызывается метод presentIfEmailExists с корректными данными.
    func testCheckEmailExistsSuccess() {
        // Arrange:
        let dummyResponse = LoginModels.IsEmailExists(is_exists: true)
        mockAPIService.sendResult = dummyResponse
        
        let email = "user@example.com"
        let request = RegistrationEmailModels.CheckEmailExists.Request(email: email)
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
        XCTAssertTrue(presenterSpy.ifEmailExistsCalled, "Метод presentIfEmailExists должен быть вызван при успешной проверке почты")
        XCTAssertEqual(presenterSpy.emailExistsResponse?.isExists, true, "Флаг isExists должен быть true")
        XCTAssertEqual(presenterSpy.emailExistsResponse?.email, email, "Email должен передаваться корректно")
    }
    
    /// Тест проверяет сценарий ошибки при проверке существования почты:
    /// – эмулируется ошибка API;
    /// – проверяется, что метод presentIfEmailExists не вызывается.
    func testCheckEmailExistsFailure() {
        // Arrange:
        enum TestError: Error { case apiFailure }
        mockAPIService.sendError = TestError.apiFailure
        
        let email = "user@example.com"
        let request = RegistrationEmailModels.CheckEmailExists.Request(email: email)
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
        XCTAssertFalse(presenterSpy.ifEmailExistsCalled, "Метод presentIfEmailExists не должен вызываться при ошибке API")
    }
}
