//
//  FriendsInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class FriendsInteractorTests: XCTestCase {
    var interactor: FriendsInteractor!
    var presenterSpy: FriendsPresenterSpy!
    var mockAPIService: FriendsMockAPIService!
    
    override func setUp() {
        super.setUp()
        // Arrange
        UserDefaultsManager.shared.authToken = "testToken"
        presenterSpy = FriendsPresenterSpy()
        mockAPIService = FriendsMockAPIService()
        interactor = FriendsInteractor(presenter: presenterSpy, apiService: mockAPIService)
    }
    
    override func tearDown() {
        UserDefaultsManager.shared.authToken = nil
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testRouteToAddFriendScreen() {
        // Arrange
        let request = FriendsModels.RouteToAddFriendScreen.Request()
        
        // Act
        interactor.routeToAddFriendScreen(request)
        
        // Assert
        XCTAssertTrue(presenterSpy.routeToAddFriendScreenCalled, "routeToAddFriendScreen должен вызывать соответствующий метод презентера")
    }
    
    func testRouteToFriendProfileScreen() {
        // Arrange
        let request = FriendsModels.RouteToFriendProfileScreen.Request(email: "friend@example.com", name: "Friend Name")
        
        // Act
        interactor.routeToFriendProfileScreen(request)
        
        // Assert
        XCTAssertTrue(presenterSpy.routeToFriendProfileScreenCalled, "routeToFriendProfileScreen должен вызывать соответствующий метод презентера")
        XCTAssertEqual(presenterSpy.friendProfileResponse?.email, "friend@example.com")
        XCTAssertEqual(presenterSpy.friendProfileResponse?.name, "Friend Name")
    }
    
    func testFetchAllFriendsSuccess() {
        // Arrange
        let dummyFriend = FriendUser(email: "friend@example.com", name: "Friend Name")
        let dummyResponse = FriendsModels.GetFriendsResponse(friends: [dummyFriend], detail: "Friends loaded successfully")
        mockAPIService.getResult = dummyResponse
        
        let expectation = self.expectation(description: "Ожидаем вызова presentAllFriends")
        
        // Act
        interactor.fetchAllFriends(FriendsModels.FetchAllFriends.Request())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            if self.presenterSpy.presentAllFriendsCalled {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(presenterSpy.presentAllFriendsCalled, "presentAllFriends должен быть вызван при успешном получении данных друзей")
        XCTAssertEqual(interactor.friends.count, 1, "Должен быть получен один друг")
    }
    
    func testFetchAllFriendsFailure() {
        // Arrange
        enum TestError: Error { case someError }
        mockAPIService.getError = TestError.someError
        
        let expectation = self.expectation(description: "Ожидаем вызова retryFetchAllFriends")
        
        // Act
        interactor.fetchAllFriends(FriendsModels.FetchAllFriends.Request())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            if self.presenterSpy.retryFetchAllFriendsCalled {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(presenterSpy.retryFetchAllFriendsCalled, "retryFetchAllFriends должен быть вызван при ошибке получения списка друзей")
    }
    
    func testDeleteFriendSuccess() {
        // Arrange
        let dummyDeleteResponse = FriendsModels.DeleteFriendResponse(detail: "Friend deleted successfully")
        mockAPIService.sendResult = dummyDeleteResponse
        
        let request = FriendsModels.DeleteFriend.Request(email: "friend@example.com")
        
        // Act
        interactor.deleteFriend(request)
        
        let expectation = self.expectation(description: "Ожидаем завершения deleteFriend")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert
        XCTAssertNotNil(mockAPIService.lastSendEndpoint, "Метод send должен был быть вызван при удалении друга")
        // Проверяем, что в теле запроса передается корректный email
        if let body = mockAPIService.lastSendBody as? FriendsModels.Email {
            XCTAssertEqual(body.email, "friend@example.com", "В теле запроса должен быть указан корректный email")
        } else {
            XCTFail("Тело запроса должно быть типа FriendsModels.Email")
        }
    }
    
    func testDeleteFriendFailure() {
        // Arrange
        enum TestError: Error { case deletionError }
        mockAPIService.sendError = TestError.deletionError
        
        let request = FriendsModels.DeleteFriend.Request(email: "friend@example.com")
        
        // Act
        interactor.deleteFriend(request)
        
        let expectation = self.expectation(description: "Ожидаем завершения deleteFriend с ошибкой")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert
        XCTAssertNotNil(mockAPIService.lastSendEndpoint, "Метод send должен быть вызван даже при ошибке удаления")
    }
}
