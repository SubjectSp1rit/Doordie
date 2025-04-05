//
//  ProfileModels.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

enum ProfileModels {
    enum RouteToAddFriendScreen {
        struct Request { }
        struct Response { }
    }
    
    enum FetchAllFriends {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    struct FriendUser: Decodable {
        var email: String?
        var name: String?
    }
    
    struct GetFriendsResponse: Decodable {
        var friends: [FriendUser]?
        var detail: String?
    }
}
