//
//  WelcomeInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

final class WelcomeInteractorUnitTests: XCTestCase {
    var interactor: WelcomeInteractor!
    var presenterSpy: WelcomePresenterSpy!

    override func setUp() {
        super.setUp()
        presenterSpy = WelcomePresenterSpy()
        interactor = WelcomeInteractor(presenter: presenterSpy)
    }

    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        super.tearDown()
    }

    /// Проверяем, что при вызове routeToLoginScreen Interactor вызывает метод презентера routeToLoginScreen
    func testRouteToLoginScreen() {
        // Arrange:
        let request = WelcomeModels.RouteToLoginScreen.Request()
        
        // Act:
        interactor.routeToLoginScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.routeToLoginScreenCalled, "routeToProfileScreen должен вызвать метод презентера")
    }

    /// Проверяем, что при вызове routeToRegistrationScreen Interactor вызывает метод презентера routeToRegistrationScreen
    func testRouteToRegistrationScreen() {
        // Arrange:
        let request = WelcomeModels.RouteToRegistrationScreen.Request()
        
        // Act:
        interactor.routeToRegistrationScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.routeToRegistrationScreenCalled, "routeToProfileScreen должен вызвать метод презентера")
    }
}
