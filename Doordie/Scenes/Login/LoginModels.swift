//
//  LoginModels.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

enum LoginModels {
    enum RouteToRestorePasswordScreen {
        struct Request {
            var email: String?
        }
        struct Response {
            var email: String?
        }
    }
    
    enum RouteToRegistrationScreen {
        struct Request { }
        struct Response { }
    }
}

