//
//  RegistrationEmailCodeInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationEmailCodeInteractorUnitTests: XCTestCase {
    var interactor: RegistrationEmailCodeInteractor!
    var presenterSpy: RegistrationEmailCodePresenterSpy!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        presenterSpy = RegistrationEmailCodePresenterSpy()
        mockAPIService = MockAPIService()
        interactor = RegistrationEmailCodeInteractor(presenter: presenterSpy, apiService: mockAPIService)
    }
    
    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    /// Тест проверяет, что метод routeToRegistrationNameScreen вызывает соответствующий метод презентера
    /// и передаёт корректный email.
    func testRouteToRegistrationNameScreen() {
        // Arrange:
        let email = "test@example.com"
        let request = RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Request(email: email)
        
        // Act:
        interactor.routeToRegistrationNameScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.routeToRegistrationNameScreenCalled, "Метод routeToRegistrationNameScreen должен быть вызван")
        XCTAssertEqual(presenterSpy.routeToRegistrationNameScreenResponse?.email, email, "Email должен передаваться корректно")
    }
    
    /// Тест проверяет успешную отправку сообщения с кодом:
    /// – эмулируется успешный ответ API через мок‑сервис;
    /// – проверяется, что презентер получает вызов presentCode с корректным 4‑значным кодом.
    func testSendEmailMessageSuccess() {
        // Arrange:
        let email = "test@example.com"
        let request = RegistrationEmailCodeModels.SendEmailMessage.Request(email: email)
        
        // Подменяем успешный ответ API.
        // В данном случае содержимое ответа не важно – достаточно, чтобы вызвался блок success.
        let dummyResponse = RegistrationEmailCodeModels.EmailMessageResponse(detail: "Email sent successfully")
        mockAPIService.sendResult = dummyResponse
        
        let expectation = self.expectation(description: "Ожидаем вызова presentCode")
        
        // Act:
        interactor.sendEmailMessage(request)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.presentCodeCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.presentCodeCalled, "Метод presentCode должен быть вызван при успешной отправке сообщения")
        if let code = presenterSpy.presentCodeResponse?.code {
            XCTAssertEqual(code.count, 4, "Код должен состоять из 4 цифр")
        } else {
            XCTFail("Код не должен быть nil")
        }
    }
    
    /// Тест проверяет сценарий ошибки при отправке сообщения с кодом:
    /// – эмулируется ошибка API через мок‑сервис;
    /// – проверяется, что метод presentCode презентера не вызывается.
    func testSendEmailMessageFailure() {
        // Arrange:
        enum TestError: Error { case apiFailure }
        mockAPIService.sendError = TestError.apiFailure
        
        let email = "test@example.com"
        let request = RegistrationEmailCodeModels.SendEmailMessage.Request(email: email)
        presenterSpy.presentCodeCalled = false
        
        let expectation = self.expectation(description: "Ожидаем, что presentCode НЕ будет вызван")
        expectation.isInverted = true // Инвертированное ожидание
        
        // Act:
        interactor.sendEmailMessage(request)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.presentCodeCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertFalse(presenterSpy.presentCodeCalled, "Метод presentCode не должен вызываться при ошибке API")
    }
}
