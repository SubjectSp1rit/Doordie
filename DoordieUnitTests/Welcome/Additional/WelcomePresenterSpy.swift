//
//  WelcomePresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

final class WelcomePresenterSpy: WelcomePresentationLogic {
    var routeToLoginScreenCalled = false
    var routeToRegistrationScreenCalled = false
    
    func routeToLoginScreen(_ response: Doordie.WelcomeModels.RouteToLoginScreen.Response) {
        routeToLoginScreenCalled = true
    }
    
    func routeToRegistrationScreen(_ response: Doordie.WelcomeModels.RouteToRegistrationScreen.Response) {
        routeToRegistrationScreenCalled = true
    }
}

