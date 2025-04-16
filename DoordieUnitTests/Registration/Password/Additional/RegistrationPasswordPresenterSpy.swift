//
//  RegistrationPasswordPresenterSpy.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class RegistrationPasswordPresenterSpy: RegistrationPasswordPresentationLogic {
    var presentCreateAccountCalled = false
    
    func presentCreateAccount(_ response: RegistrationPasswordModels.CreateAccount.Response) {
        presentCreateAccountCalled = true
    }
}
