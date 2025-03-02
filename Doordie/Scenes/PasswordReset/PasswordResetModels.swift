//
//  PasswordResetModels.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

enum PasswordResetModels {
    enum PresentSentPopup {
        struct Request {
            var mail: String
        }
        struct Response {
            var mail: String
        }
    }
}
