//
//  RegistrationEmailPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationEmailPresenterSpy: RegistrationEmailPresentationLogic {
    var codeScreenCalled = false
    var loginScreenCalled = false
    var ifEmailExistsCalled = false
    
    var routeToCodeResponse: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response?
    var routeToLoginResponse: RegistrationEmailModels.RouteToLoginScreen.Response?
    var emailExistsResponse: RegistrationEmailModels.CheckEmailExists.Response?
    
    func routeToRegistrationEmailCodeScreen(_ response: RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Response) {
        codeScreenCalled = true
        routeToCodeResponse = response
    }
    
    func routeToLoginScreen(_ response: RegistrationEmailModels.RouteToLoginScreen.Response) {
        loginScreenCalled = true
        routeToLoginResponse = response
    }
    
    func presentIfEmailExists(_ response: RegistrationEmailModels.CheckEmailExists.Response) {
        ifEmailExistsCalled = true
        emailExistsResponse = response
    }
}
