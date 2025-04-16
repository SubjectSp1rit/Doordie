//
//  AddFriendMockAPIService.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 10.04.2025.
//

@testable import Doordie

class AddFriendMockAPIService: APIServiceProtocol {
    var sendCalled = false
    var sendEndpoint: APIEndpoint?
    var resultToReturn: Result<AddFriendModels.AddFriendResponse, Error>?

    func send<T: Decodable, U: Encodable>(
        endpoint: APIEndpoint,
        body: U,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        sendCalled = true
        sendEndpoint = endpoint
        if let result = resultToReturn {
            completion(result as! Result<T, Error>)
        }
    }

    func get<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        // Не используется
    }
}
