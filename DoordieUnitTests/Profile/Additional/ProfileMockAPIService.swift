//
//  ProfileMockAPIService.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 16.04.2025.
//

import XCTest
@testable import Doordie

class ProfileMockAPIService: APIServiceProtocol {
    var sendResult: Any?
    var sendError: Error?
    
    var getResult: Any?
    var getError: Error?
    
    var lastSendEndpoint: APIEndpoint?
    var lastSendBody: Any?
    
    var lastGetEndpoint: APIEndpoint?
    
    func send<T: Decodable, U: Encodable>(
        endpoint: APIEndpoint,
        body: U,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
    {
        lastSendEndpoint = endpoint
        lastSendBody = body
        if let error = sendError {
            completion(.failure(error))
        } else if let result = sendResult as? T {
            completion(.success(result))
        }
    }
    
    func get<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
    {
        lastGetEndpoint = endpoint
        if let error = getError {
            completion(.failure(error))
        } else if let result = getResult as? T {
            completion(.success(result))
        }
    }
}
