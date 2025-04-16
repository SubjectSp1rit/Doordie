//
//  ProfileInteractorUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class ProfileInteractorUnitTests: XCTestCase {
    var interactor: ProfileInteractor!
    var presenterSpy: ProfilePresenterSpy!
    var mockAPIService: ProfileMockAPIService!
    
    let dummyFriend = FriendUser(email: "friend@example.com", name: "Test Friend")
    
    override func setUp() {
        super.setUp()
        presenterSpy = ProfilePresenterSpy()
        mockAPIService = ProfileMockAPIService()
        interactor = ProfileInteractor(presenter: presenterSpy, apiService: mockAPIService)
    }
    
    override func tearDown() {
        interactor = nil
        presenterSpy = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    /// Проверяем, что при вызове routeToAddFriendScreen вызывается соответствующий метод презентера.
    func testRouteToAddFriendScreen() {
        // Arrange:
        let request = ProfileModels.RouteToAddFriendScreen.Request()
        
        // Act:
        interactor.routeToAddFriendScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.addFriendScreenCalled, "routeToAddFriendScreen должен вызвать метод презентера")
    }
    
    /// Проверяем, что при вызове routeToFriendProfileScreen передаются корректные данные.
    func testRouteToFriendProfileScreen() {
        // Arrange:
        let request = ProfileModels.RouteToFriendProfileScreen.Request(email: "friend@example.com", name: "Test Friend")
        
        // Act:
        interactor.routeToFriendProfileScreen(request)
        
        // Assert:
        XCTAssertTrue(presenterSpy.friendProfileScreenCalled, "routeToFriendProfileScreen должен вызвать метод презентера")
        XCTAssertEqual(presenterSpy.friendProfileResponse?.email, "friend@example.com", "Email должен передаваться корректно")
        XCTAssertEqual(presenterSpy.friendProfileResponse?.name, "Test Friend", "Name должен передаваться корректно")
    }
    
    /// Тест успешного получения списка друзей:
    /// – эмулируем ответ API с данными, проверяем, что массив друзей обновлён и вызывается presenter.presentAllFriends.
    func testFetchAllFriendsSuccess() {
        // Arrange:
        // Сохраняем тестовый токен, чтобы guard не прервал выполнение.
        UserDefaultsManager.shared.authToken = "testToken"
        
        let dummyResponse = ProfileModels.GetFriendsResponse(friends: [dummyFriend], detail: "Друзья загружены")
        mockAPIService.getResult = dummyResponse
        
        let expectation = self.expectation(description: "Ожидаем вызова presentAllFriends")
        
        // Act:
        interactor.fetchAllFriends(ProfileModels.FetchAllFriends.Request())
        
        // Ждём асинхронного выполнения
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.presentAllFriendsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.presentAllFriendsCalled, "presentAllFriends должен быть вызван при успешном получении данных")
        XCTAssertEqual(interactor.friends.count, 1, "Должен быть получен один друг")
    }
    
    /// Тест ошибки при получении списка друзей:
    /// – эмулируется ошибка API, проверяется, что вызывается метод retryFetachAllFriends.
    func testFetchAllFriendsFailure() {
        // Arrange:
        UserDefaultsManager.shared.authToken = "testToken"
        enum TestError: Error { case fetchError }
        mockAPIService.getError = TestError.fetchError
        
        let expectation = self.expectation(description: "Ожидаем вызова retryFetachAllFriends")
        
        // Act:
        interactor.fetchAllFriends(ProfileModels.FetchAllFriends.Request())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.presenterSpy.retryFetchAllFriendsCalled {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertTrue(presenterSpy.retryFetchAllFriendsCalled, "retryFetachAllFriends должен быть вызван при ошибке получения данных")
    }
    
    /// Тест удаления друга:
    /// – эмулируется успешное выполнение запроса на удаление,
    /// – проверяется, что метод send вызывается с корректными данными (например, переданный email).
    func testDeleteFriend() {
        // Arrange:
        UserDefaultsManager.shared.authToken = "testToken"
        let request = ProfileModels.DeleteFriend.Request(email: "friend@example.com")
        
        let dummyDeleteResponse = ProfileModels.DeleteFriendResponse(detail: "Друг успешно удалён")
        mockAPIService.sendResult = dummyDeleteResponse
        
        let expectation = self.expectation(description: "Ожидаем завершения deleteFriend")
        
        // Act:
        interactor.deleteFriend(request)
        
        // Ждём асинхронного выполнения
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Assert:
        XCTAssertNotNil(mockAPIService.lastSendEndpoint, "Метод send должен быть вызван для удаления друга")
        if let body = mockAPIService.lastSendBody as? ProfileModels.Email {
            XCTAssertEqual(body.email, "friend@example.com", "В теле запроса должен передаваться корректный email")
        } else {
            XCTFail("Тело запроса должно быть типа ProfileModels.Email")
        }
    }
}
