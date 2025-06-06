//
//  SettingsModels.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum SettingsModels {
    enum RouteToProfileScreen {
        struct Request { }
        struct Response { }
    }
    
    enum OpenTelegram {
        struct Request {
            let link: String
        }
        struct Response {
            let link: String
        }
    }
    
    enum ShowLogoutAlert {
        struct Request { }
        struct Response { }
    }
}
