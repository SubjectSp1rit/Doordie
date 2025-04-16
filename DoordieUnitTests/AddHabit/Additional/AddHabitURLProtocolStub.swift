//
//  AddHabitURLProtocolStub.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 10.04.2025.
//

import XCTest
@testable import Doordie

class AddHabitURLProtocolStub: URLProtocol {
    static var stubResponseData: Data?
    static var stubError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = AddHabitURLProtocolStub.stubError {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = AddHabitURLProtocolStub.stubResponseData {
                client?.urlProtocol(self, didLoad: data)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // Ничего не делаем
    }
}
