//
//  EmailCodeModels.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

enum RegistrationEmailCodeModels {
    enum RouteToRegistrationNameScreen {
        struct Request {
            var email: String
        }
        struct Response {
            var email: String
        }
    }
    
    enum SendEmailMessage {
        struct Request {
            var email: String
        }
        struct Response {
            var code: String
        }
        struct ViewModel {
            var code: String
        }
    }
    
    struct EmailMessageRequest: Encodable {
        var email: String
        var subject: String
        var message: String
    }
    
    struct EmailMessageResponse: Decodable {
        var detail: String?
    }
}

