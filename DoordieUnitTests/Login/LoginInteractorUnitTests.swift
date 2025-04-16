//
//  LoginInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class LoginInteractorUnitTests: XCTestCase {
    var interactor: LoginInteractor!
    var presenterSpy: LoginPresenterSpy!
    var mockAPIService: LoginMockAPIService!
    
    override func setUp() {
        super.setUp()
        // Arrange
        presenterSpy = LoginPresenterSpy()
        mockAPIService = LoginMockAPIService()
        interactor = LoginInteractor(presenter: presenterSpy, apiService: mockAPIService)
        UserDefaultsManager.shared.authToken = nil
        UserDefaultsManager.shared.name = nil
    }
    
    override func tearDown() {
        UserDefaultsManager.shared.authToken = nil
        UserDefaultsManager.shared.name = nil
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    /// Проверяем, что при вызове showRestorePasswordScreen вызывается метод презентера с правильным email
    func testShowRestorePasswordScreen() {
        // Arrange:
        let request = LoginModels.RouteToRestorePasswordScreen.Request(email: "restore@example.com")
        
        // Act:
        interactor.showRestorePasswordScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.restorePasswordScreenCalled, "presentRestorePasswordScreen должен быть вызван")
        XCTAssertEqual(presenterSpy.restorePasswordResponse?.email, "restore@example.com", "Email должен передаваться корректно")
    }
    
    /// Проверяем, что при вызове showRegistrationScreen вызывается метод презентера с правильным email
    func testShowRegistrationScreen() {
        // Arrange:
        let request = LoginModels.RouteToRegistrationScreen.Request(email: "register@example.com")
        
        // Act:
        interactor.showRegistrationScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.registrationScreenCalled, "presentRegistrationScreen должен быть вызван")
        XCTAssertEqual(presenterSpy.registrationResponse?.email, "register@example.com", "Email должен передаваться корректно")
    }
    
    /// Проверяем, что при вызове routeToHomeScreen вызывается метод презентера для перехода на главный экран
    func testRouteToHomeScreen() {
        // Arrange:
        let request = LoginModels.RouteToHomeScreen.Request()
        
        // Act:
        interactor.routeToHomeScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.homeScreenCalled, "presentHomeScreen должен быть вызван")
    }
    
    /// Тест успешного входа пользователя:
    /// - эмулируем ответ API с флагом is_success = true, а также возвращаем token и name;
    /// - проверяем, что presenter.presentLoginResult вызывается с isSuccess = true,
    ///   а также что токен и имя сохраняются в UserDefaultsManager.
    func testLoginUserSuccess() {
        // Arrange:
        let dummyResponse = LoginModels.LoginResponse(token: "dummyToken", name: "John Doe", is_success: true)
        mockAPIService.sendResult = dummyResponse
        
        let expectation = self.expectation(description: "Ожидаем вызова presentLoginResult для успешного входа")
        
        // Act:
        interactor.loginUser(LoginModels.LoginUser.Request(email: "test@example.com", password: "password123"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.loginResultCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.loginResultCalled, "presentLoginResult должен быть вызван при успешном входе")
        XCTAssertEqual(presenterSpy.loginResultResponse?.isSuccess, true, "isSuccess должен быть true при корректном входе")
        XCTAssertEqual(UserDefaultsManager.shared.authToken, "dummyToken", "Токен должен быть сохранён")
        XCTAssertEqual(UserDefaultsManager.shared.name, "John Doe", "Имя должно быть сохранено")
    }
    
    /// Тест входа с неправильным паролем:
    /// - эмулируем ответ API с is_success = false;
    /// - проверяем, что presenter.presentLoginResult вызывается с isSuccess = false,
    ///   и токен не сохраняется.
    func testLoginUserWrongPassword() {
        // Arrange:
        let dummyResponse = LoginModels.LoginResponse(token: nil, name: nil, is_success: false)
        mockAPIService.sendResult = dummyResponse
        
        let expectation = self.expectation(description: "Ожидаем вызова presentLoginResult для неправильного пароля")
        
        // Act:
        interactor.loginUser(LoginModels.LoginUser.Request(email: "test@example.com", password: "wrongpassword"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.loginResultCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.loginResultCalled, "presentLoginResult должен быть вызван при неправильном пароле")
        XCTAssertEqual(presenterSpy.loginResultResponse?.isSuccess, false, "isSuccess должен быть false при неправильном пароле")
        XCTAssertNil(UserDefaultsManager.shared.authToken, "Токен не должен сохраняться при неправильном пароле")
    }
    
    /// Тест входа с ошибкой API:
    /// - эмулируем ошибку API при вызове loginUser;
    /// - проверяем, что метод презентера (presentLoginResult) не вызывается.
    func testLoginUserAPIFailure() {
        // Arrange:
        enum TestError: Error { case apiFailure }
        mockAPIService.sendError = TestError.apiFailure
        
        presenterSpy.loginResultCalled = false
        
        // Act:
        interactor.loginUser(LoginModels.LoginUser.Request(email: "test@example.com", password: "password123"))
        
        let expectation = self.expectation(description: "Ожидаем, что presentLoginResult НЕ будет вызван")
        expectation.isInverted = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.loginResultCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertFalse(presenterSpy.loginResultCalled, "presentLoginResult не должен вызываться при ошибке API")
        XCTAssertNil(UserDefaultsManager.shared.authToken, "Токен не должен сохраняться при ошибке API")
    }
    
    /// Тест успешной проверки существования почты:
    /// - эмулируем ответ API, где is_exists = true;
    /// - проверяем, что вызывается метод presentIfEmailExists с корректными данными.
    func testCheckEmailExistsSuccess() {
        // Arrange:
        let dummyResponse = LoginModels.IsEmailExists(is_exists: true)
        mockAPIService.sendResult = dummyResponse
        
        let expectation = self.expectation(description: "Ожидаем вызова presentIfEmailExists")
        
        // Act:
        interactor.checkEmailExists(LoginModels.CheckEmailExists.Request(email: "test@example.com"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.emailExistsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.emailExistsCalled, "presentIfEmailExists должен быть вызван при успешной проверке почты")
        XCTAssertEqual(presenterSpy.emailExistsResponse?.isExists, true, "Флаг isExists должен быть true")
        XCTAssertEqual(presenterSpy.emailExistsResponse?.email, "test@example.com", "Email должен передаваться корректно")
    }
    
    /// Тест проверки существования почты при ошибке API:
    /// - эмулируем ошибку API;
    /// - проверяем, что метод presentIfEmailExists не вызывается.
    func testCheckEmailExistsFailure() {
        // Arrange:
        enum TestError: Error { case apiFailure }
        mockAPIService.sendError = TestError.apiFailure
        
        presenterSpy.emailExistsCalled = false
        
        // Act:
        interactor.checkEmailExists(LoginModels.CheckEmailExists.Request(email: "test@example.com"))
        
        let expectation = self.expectation(description: "Ожидаем, что presentIfEmailExists НЕ будет вызван")
        expectation.isInverted = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.emailExistsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertFalse(presenterSpy.emailExistsCalled, "presentIfEmailExists не должен вызываться при ошибке API")
    }
}

