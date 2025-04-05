//
//  AddFriendModels.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

enum AddFriendModels {
    enum SendFriendRequest {
        struct Request {
            var email: String
        }
        struct Response { }
    }
    
    struct AddFriendResponse: Decodable {
        var detail: String?
    }
    
    struct Email: Encodable {
        var email: String
    }
}

