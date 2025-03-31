//
//  RegistrationEmailModels.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

enum RegistrationEmailModels {
    enum RouteToRegistrationEmailCodeScreen {
        struct Request {
            var email: String
        }
        struct Response {
            var email: String
        }
    }
    
    enum RouteToLoginScreen {
        struct Request {
            var email: String
        }
        struct Response {
            var email: String
        }
    }
    
    enum CheckEmailExists {
        struct Request {
            var email: String
        }
        struct Response {
            var isExists: Bool
            var email: String
        }
        struct ViewModel {
            var isExists: Bool
            var email: String
        }
    }
    
    struct IsEmailExists: Codable {
        var is_exists: Bool?
    }
    
    struct Email: Codable {
        var email: String
    }
}

