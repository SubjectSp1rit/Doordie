//
//  AddFriendMockPresenter.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 10.04.2025.
//

import XCTest
@testable import Doordie

class AddFriendMockPresenter: AddFriendPresentationLogic {
    var presentCalled = false
    var response: AddFriendModels.SendFriendRequest.Response?
    var expectation: XCTestExpectation?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func presentFriendRequest(_ response: AddFriendModels.SendFriendRequest.Response) {
        presentCalled = true
        self.response = response
        expectation?.fulfill()
    }
}
