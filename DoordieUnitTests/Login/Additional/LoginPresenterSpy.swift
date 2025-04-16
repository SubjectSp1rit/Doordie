//
//  LoginPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class LoginPresenterSpy: LoginPresentationLogic {
    var restorePasswordScreenCalled = false
    var registrationScreenCalled = false
    var homeScreenCalled = false
    var emailExistsCalled = false
    var loginResultCalled = false
    
    var restorePasswordResponse: LoginModels.RouteToRestorePasswordScreen.Response?
    var registrationResponse: LoginModels.RouteToRegistrationScreen.Response?
    var emailExistsResponse: LoginModels.CheckEmailExists.Response?
    var loginResultResponse: LoginModels.LoginUser.Response?
    
    func presentRestorePasswordScreen(_ response: LoginModels.RouteToRestorePasswordScreen.Response) {
        restorePasswordScreenCalled = true
        restorePasswordResponse = response
    }
    
    func presentRegistrationScreen(_ response: LoginModels.RouteToRegistrationScreen.Response) {
        registrationScreenCalled = true
        registrationResponse = response
    }
    
    func presentHomeScreen(_ response: LoginModels.RouteToHomeScreen.Response) {
        homeScreenCalled = true
    }
    
    func presentIfEmailExists(_ response: LoginModels.CheckEmailExists.Response) {
        emailExistsCalled = true
        emailExistsResponse = response
    }
    
    func presentLoginResult(_ response: LoginModels.LoginUser.Response) {
        loginResultCalled = true
        loginResultResponse = response
    }
}
