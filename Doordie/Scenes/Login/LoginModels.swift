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
        struct Request {
            var email: String?
        }
        struct Response {
            var email: String?
        }
    }
    
    enum RouteToHomeScreen {
        struct Request { }
        struct Response { }
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
    
    struct LoginUser {
        struct Request {
            var email: String
            var password: String
        }
        struct Response {
            var isSuccess: Bool
        }
        struct viewModel {
            var isSuccess: Bool
        }
    }
}

// Модели для сетевых запросов и ответов
extension LoginModels {
    struct LoginResponse: Codable {
        var token: String?
        var is_success: Bool?
    }
    
    struct IsEmailExists: Codable {
        var is_exists: Bool?
    }
    
    struct Email: Codable {
        var email: String
    }
}

