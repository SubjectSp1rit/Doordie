//
//  RegistrationPasswordModels.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

enum RegistrationPasswordModels {
    enum CreateAccount {
        struct Request {
            var email: String
            var name: String
            var password: String
        }
        struct Response { }
        struct ViewModel { }
    }
}

