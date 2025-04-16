//
//  RegistrationNamePresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationNamePresenterSpy: RegistrationNamePresentationLogic {
    var routeToRegistrationPasswordCalled = false
    var capturedResponse: RegistrationNameModels.RouteToRegistrationPasswordScreen.Response?
    
    func routeToRegistrationPassword(_ response: RegistrationNameModels.RouteToRegistrationPasswordScreen.Response) {
        routeToRegistrationPasswordCalled = true
        capturedResponse = response
        print("routeToRegistrationPassword вызван с email: \(response.email), name: \(response.name)")
    }
}
