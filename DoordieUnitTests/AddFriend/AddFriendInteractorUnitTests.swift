//
//  AddFriendInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 10.04.2025.
//

import XCTest
@testable import Doordie

final class AddFriendInteractorUnitTests: XCTestCase {

    override func tearDown() {
        UserDefaultsManager.shared.authToken = nil
        super.tearDown()
    }

    func testSendFriendRequestSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Ожидается вызов презентера при успешном запросе")
        let mockPresenter = AddFriendMockPresenter(expectation: expectation)
        let mockAPIService = AddFriendMockAPIService()
        mockAPIService.resultToReturn = .success(.init(detail: "Friend added"))

        UserDefaultsManager.shared.authToken = "dummy-token"
        let interactor = AddFriendInteractor(presenter: mockPresenter, apiService: mockAPIService)
        let request = AddFriendModels.SendFriendRequest.Request(email: "test@example.com")

        // Act
        interactor.sendFriendRequest(request)

        // Assert
        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(mockAPIService.sendCalled, "Метод APIService.send должен быть вызван")
            XCTAssertTrue(mockPresenter.presentCalled, "Презентер должен быть вызван при успешном ответе API")
            XCTAssertEqual(mockAPIService.sendEndpoint?.headers["Token"], "dummy-token")
            XCTAssertEqual(mockAPIService.sendEndpoint?.headers["Content-Type"], "application/json")
        }
    }

    func testSendFriendRequestFailure() {
        // Arrange
        let expectation = self.expectation(description: "Ожидается вызов презентера при ошибке API")
        let mockPresenter = AddFriendMockPresenter(expectation: expectation)
        let mockAPIService = AddFriendMockAPIService()
        mockAPIService.resultToReturn = .failure(NetworkError.noData)

        UserDefaultsManager.shared.authToken = "dummy-token"
        let interactor = AddFriendInteractor(presenter: mockPresenter, apiService: mockAPIService)
        let request = AddFriendModels.SendFriendRequest.Request(email: "test@example.com")

        // Act
        interactor.sendFriendRequest(request)

        // Assert
        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(mockAPIService.sendCalled, "Метод APIService.send должен быть вызван даже при ошибке")
            XCTAssertTrue(mockPresenter.presentCalled, "Презентер должен быть вызван даже при неудачном ответе API")
        }
    }

    func testSendFriendRequestWithoutToken() {
        // Arrange
        let mockPresenter = AddFriendMockPresenter()
        let mockAPIService = AddFriendMockAPIService()
        UserDefaultsManager.shared.authToken = nil
        let interactor = AddFriendInteractor(presenter: mockPresenter, apiService: mockAPIService)
        let request = AddFriendModels.SendFriendRequest.Request(email: "test@example.com")

        // Act
        interactor.sendFriendRequest(request)

        // Assert
        let noCallExpectation = expectation(description: "API не должен вызываться при отсутствии токена")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            noCallExpectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            XCTAssertFalse(mockAPIService.sendCalled, "Метод APIService.send не должен быть вызван без токена")
            XCTAssertFalse(mockPresenter.presentCalled, "Презентер не должен быть вызван без токена")
        }
    }
}

