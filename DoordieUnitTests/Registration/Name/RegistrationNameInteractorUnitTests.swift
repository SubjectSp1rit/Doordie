//
//  RegistrationNameInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationNameInteractorUnitTests: XCTestCase {
    var interactor: RegistrationNameInteractor!
    var presenterSpy: RegistrationNamePresenterSpy!
    
    override func setUp() {
        super.setUp()
        presenterSpy = RegistrationNamePresenterSpy()
        interactor = RegistrationNameInteractor(presenter: presenterSpy)
    }
    
    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        super.tearDown()
    }
    
    /// Проверяем, что метод routeToRegistrationPassword вызывает соответствующий метод презентера
    /// с корректно переданными email и name.
    func testRouteToRegistrationPassword_callsPresenterWithCorrectData() {
        // Arrange:
        let email = "test@example.com"
        let name = "John Doe"
        let request = RegistrationNameModels.RouteToRegistrationPasswordScreen.Request(email: email, name: name)
        
        // Act:
        interactor.routeToRegistrationPassword(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.routeToRegistrationPasswordCalled, "routeToRegistrationPassword должен быть вызван")
        XCTAssertEqual(presenterSpy.capturedResponse?.email, email, "Email не соответствует ожидаемому значению")
        XCTAssertEqual(presenterSpy.capturedResponse?.name, name, "Name не соответствует ожидаемому значению")
    }
}
