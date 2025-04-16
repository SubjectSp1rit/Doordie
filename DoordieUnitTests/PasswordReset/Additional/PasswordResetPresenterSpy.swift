//
//  PasswordResetPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class PasswordResetPresenterSpy: PasswordResetPresentationLogic {
    var sentPopupCalled = false
    var registrationEmailScreenCalled = false
    var ifEmailExistsCalled = false
    
    var sentPopupResponse: PasswordResetModels.PresentSentPopup.Response?
    var registrationEmailResponse: PasswordResetModels.RouteToRegistrationEmailScreen.Response?
    var checkEmailExistsResponse: PasswordResetModels.CheckEmailExists.Response?
    
    func presentSentPopup(_ response: PasswordResetModels.PresentSentPopup.Response) {
        sentPopupCalled = true
        sentPopupResponse = response
    }
    
    func routeToRegistrationEmailScreen(_ response: PasswordResetModels.RouteToRegistrationEmailScreen.Response) {
        registrationEmailScreenCalled = true
        registrationEmailResponse = response
    }
    
    func presentIfEmailExists(_ response: PasswordResetModels.CheckEmailExists.Response) {
        ifEmailExistsCalled = true
        checkEmailExistsResponse = response
    }
}
