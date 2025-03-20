//
//  RegistrationNameModels.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

enum RegistrationNameModels {
    enum RouteToRegistrationPasswordScreen {
        struct Request {
            var email: String
            var name: String
        }
        struct Response {
            var email: String
            var name: String
        }
    }
}

