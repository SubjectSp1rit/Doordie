//
//  RegistrationPasswordInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationPasswordInteractorUnitTests: XCTestCase {
    var interactor: RegistrationPasswordInteractor!
    var presenterSpy: RegistrationPasswordPresenterSpy!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        presenterSpy = RegistrationPasswordPresenterSpy()
        mockAPIService = MockAPIService()
        interactor = RegistrationPasswordInteractor(presenter: presenterSpy, apiService: mockAPIService)
        
        UserDefaultsManager.shared.authToken = nil
        UserDefaultsManager.shared.name = nil
    }
    
    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        UserDefaultsManager.shared.authToken = nil
        UserDefaultsManager.shared.name = nil
        super.tearDown()
    }
    
    /// Тест успешного создания аккаунта.
    /// Эмулируется успешный ответ API (с фиктивным токеном и именем),
    /// после чего проверяется, что:
    /// 1. Вызывается метод presentCreateAccount презентера;
    /// 2. Значения токена и имени сохраняются в UserDefaultsManager.
    func testCreateAccountSuccess() {
        // Arrange:
        let request = RegistrationPasswordModels.CreateAccount.Request(email: "user@example.com", name: "John Doe", password: "password123")
        
        let dummyToken = Token(token: "dummyToken", name: "John Doe")
        mockAPIService.sendResult = dummyToken
        
        let expectation = self.expectation(description: "Ожидаем вызова presentCreateAccount")
        
        // Act:
        interactor.createAccount(request)
        
        // Ждем асинхронного выполнения.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.presentCreateAccountCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.presentCreateAccountCalled, "Метод presentCreateAccount должен быть вызван при успешной регистрации")
        XCTAssertEqual(UserDefaultsManager.shared.authToken, "dummyToken", "Токен должен быть сохранён корректно")
        XCTAssertEqual(UserDefaultsManager.shared.name, "John Doe", "Имя должно быть сохранено корректно")
    }
    
    /// Тест ошибки создания аккаунта.
    /// Эмулируется ошибка API, проверяется, что метод presentCreateAccount не вызывается,
    /// и в UserDefaultsManager не сохраняются данные.
    func testCreateAccountFailure() {
        // Arrange:
        enum TestError: Error { case apiFailure }
        mockAPIService.sendError = TestError.apiFailure
        
        let request = RegistrationPasswordModels.CreateAccount.Request(email: "user@example.com", name: "John Doe", password: "password123")
        presenterSpy.presentCreateAccountCalled = false
        
        UserDefaultsManager.shared.authToken = nil
        UserDefaultsManager.shared.name = nil
        
        let expectation = self.expectation(description: "Ожидаем, что presentCreateAccount НЕ будет вызван")
        expectation.isInverted = true
        
        // Act:
        interactor.createAccount(request)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.presentCreateAccountCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertFalse(presenterSpy.presentCreateAccountCalled, "Метод presentCreateAccount не должен вызываться при ошибке регистрации")
        XCTAssertNil(UserDefaultsManager.shared.authToken, "Токен не должен сохраняться при ошибке регистрации")
        XCTAssertNil(UserDefaultsManager.shared.name, "Имя не должно сохраняться при ошибке регистрации")
    }
}
