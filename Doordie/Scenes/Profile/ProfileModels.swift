//
//  ProfileModels.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

enum ProfileModels {
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
    
    struct GetFriendsResponse: Decodable {
        var friends: [FriendUser]?
        var detail: String?
    }
    
    struct Email: Encodable {
        var email: String
    }
    
    struct DeleteFriendResponse: Decodable {
        var detail: String?
    }
}
