//
//  FriendsModels.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum FriendsModels {
    enum RouteToFriendProfileScreen {
        struct Request {
            var email: String
            var name: String
        }
        struct Response {
            var email: String
            var name: String
        }
    }
    
    enum RouteToAddFriendScreen {
        struct Request { }
        struct Response { }
    }
    
    enum FetchAllFriends {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    enum DeleteFriend {
        struct Request {
            var email: String
        }
    }
    
    struct Email: Encodable {
        var email: String
    }
    
    struct GetFriendsResponse: Decodable {
        var friends: [FriendUser]?
        var detail: String?
    }
    
    struct DeleteFriendResponse: Decodable {
        var detail: String?
    }
}

