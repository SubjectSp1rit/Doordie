//
//  RegistrationEmailCodePresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationEmailCodePresenterSpy: RegistrationEmailCodePresentationLogic {
    var routeToRegistrationNameScreenCalled = false
    var presentCodeCalled = false
    
    var routeToRegistrationNameScreenResponse: RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Response?
    var presentCodeResponse: RegistrationEmailCodeModels.SendEmailMessage.Response?
    
    func routeToRegistrationNameScreen(_ response: RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Response) {
        routeToRegistrationNameScreenCalled = true
        routeToRegistrationNameScreenResponse = response
    }
    
    func presentCode(_ response: RegistrationEmailCodeModels.SendEmailMessage.Response) {
        presentCodeCalled = true
        presentCodeResponse = response
        print("presentCode вызван с кодом: \(response.code)")
    }
}
