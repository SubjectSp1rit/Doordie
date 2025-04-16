//
//  SettingsInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class SettingsInteractorUnitTests: XCTestCase {
    var interactor: SettingsInteractor!
    var presenterSpy: SettingsPresenterSpy!

    override func setUp() {
        super.setUp()
        presenterSpy = SettingsPresenterSpy()
        interactor = SettingsInteractor(presenter: presenterSpy)
    }

    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        super.tearDown()
    }

    /// Тест проверяет, что при вызове routeToProfileScreen Interactor
    /// вызывает метод презентера routeToProfileScreen.
    func testRouteToProfileScreen() {
        // Arrange:
        let request = SettingsModels.RouteToProfileScreen.Request()
        
        // Act:
        interactor.routeToProfileScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.routeToProfileScreenCalled, "routeToProfileScreen должен вызвать метод презентера")
    }

    /// Тест проверяет, что при вызове openTelegram Interactor
    /// передаёт корректный link в метод презентера.
    func testOpenTelegram() {
        // Arrange:
        let testLink = "doordie_app"
        let request = SettingsModels.OpenTelegram.Request(link: testLink)
        
        // Act:
        interactor.openTelegram(request)
        
        // Assert:
        XCTAssertNotNil(presenterSpy.telegramResponse, "Презентер должен получить ответ в методе openTelegram")
        XCTAssertEqual(presenterSpy.telegramResponse?.link, testLink, "Ссылка должна передаваться корректно")
    }

    /// Тест проверяет, что при вызове showLogoutAlert Interactor
    /// вызывает метод презентера presentLogoutAlert.
    func testShowLogoutAlert() {
        // Arrange:
        let request = SettingsModels.ShowLogoutAlert.Request()
        
        // Act:
        interactor.showLogoutAlert(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.logoutAlertCalled, "showLogoutAlert должен вызвать метод презентера")
    }
}
