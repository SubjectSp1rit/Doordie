//
//  NetworkingUnitTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 08.04.2025.
//

import XCTest
@testable import Doordie

final class NetworkingUnitTests: XCTestCase {
    var apiService: APIService!
    var session: URLSession!
    
    let baseURL = "http://localhost:8000"
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)
        
        apiService = APIService(baseURL: baseURL, session: session)
    }
    
    override func tearDown() {
        session = nil
        apiService = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    // MARK: - GET testing
    
    func testGet_Success() {
        // Arrange
        let dummyResponse = DummyResponse(message: "Success")
        let jsonData = try! JSONEncoder().encode(dummyResponse)
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, HTTPMethod.GET.rawValue)
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonData)
        }
        
        let expectation = self.expectation(description: "GET completion")
        
        // Act
        let endpoint = APIEndpoint(path: "/test", method: .GET, headers: [:])
        apiService.get(endpoint: endpoint, responseType: DummyResponse.self) { result in
            
            // Assert
            switch result {
                
            case .success(let response):
                XCTAssertEqual(response, dummyResponse, "Ожидался корректный ответ")
                
            case .failure(let error):
                XCTFail("Непредвиденная ошибка: \(error)")
            }
                
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGet_NoData() {
        // Arrange: возвращаем ответ без данных (nil)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        let expectation = self.expectation(description: "GET no data")
        
        // Act
        let endpoint = APIEndpoint(path: "/test", method: .GET, headers: [:])
        apiService.get(endpoint: endpoint, responseType: DummyResponse.self) { result in
            // Assert: ожидаем ошибку NetworkError.noData
            switch result {
                
            case .success:
                XCTFail("Ожидался сбой из-за отсутствия данных")
                
            case .failure(let error):
                if case NetworkError.noData = error {
                    // Все верно
                } else {
                    XCTFail("Ожидалась ошибка noData, получена: \(error)")
                }
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGet_DecodingError() {
        // Arrange: возвращаем неверный JSON для вызова ошибки декодирования
        let invalidJSON = "Invalid JSON".data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, invalidJSON)
        }
        
        let expectation = self.expectation(description: "GET decoding error")
        
        // Act
        let endpoint = APIEndpoint(path: "/test", method: .GET, headers: [:])
        apiService.get(endpoint: endpoint, responseType: DummyResponse.self) { result in
            // Assert: ждем ошибку декодирования
            switch result {
                
            case .success:
                XCTFail("Ожидалась ошибка декодирования")
                
            case .failure(let error):
                if case NetworkError.decodingError(_) = error {
                    // Всё верно
                } else {
                    XCTFail("Ожидалась ошибка decodingError, получена: \(error)")
                }
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - SEND testing
    
    func testSend_WithGETMethod_ReturnsInvalidMethodForBody() {
        // Arrange: проверяем ошибку при использовании метода GET в send методе получим ошибку
        let dummyBody = DummyRequest(message: "Test")
        let endpoint = APIEndpoint(path: "/test", method: .GET, headers: [:])
        let expectation = self.expectation(description: "Send with GET method")
        
        // Act
        apiService.send(endpoint: endpoint, body: dummyBody, responseType: DummyResponse.self) { result in
            // Assert
            switch result {
                
            case .success:
                XCTFail("Ожидалась ошибка из-за недопустимого HTTP-метода")
                
            case .failure(let error):
                if case NetworkError.invalidMethodForBody = error {
                    // Все верно
                } else {
                    XCTFail("Ожидалась ошибка invalidMethodForBody, получена: \(error)")
                }
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSend_Success() {
        // Arrange
        let dummyRequest = DummyRequest(message: "Hello")
        let dummyResponse = DummyResponse(message: "Received")
        let jsonData = try! JSONEncoder().encode(dummyResponse)
        
        MockURLProtocol.requestHandler = { request in
            // Проверка
            XCTAssertNotEqual(request.httpMethod, HTTPMethod.GET.rawValue)
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonData)
        }
        
        let endpoint = APIEndpoint(path: "/test", method: .PUT, headers: [:])
        let expectation = self.expectation(description: "Send success")
        
        // Act
        apiService.send(endpoint: endpoint, body: dummyRequest, responseType: DummyResponse.self) { result in
            // Assert
            switch result {
                
            case .success(let response):
                XCTAssertEqual(response, dummyResponse, "Ожидался корректный ответ")
                
            case .failure(let error):
                XCTFail("Непредвиденная ошибка: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSend_EncodingError() {
        // Arrange: используем тип, вызывающий ошибку при попытке кодирования
        let failingBody = FailingEncodable()
        let endpoint = APIEndpoint(path: "/test", method: .POST, headers: [:])
        let expectation = self.expectation(description: "Send encoding error")
        
        // Act
        apiService.send(endpoint: endpoint, body: failingBody, responseType: DummyResponse.self) { result in
            // Assert: ожидаем NetworkError.encodingError
            switch result {
                
            case .success:
                XCTFail("Ожидалась ошибка кодирования")
                
            case .failure(let error):
                if case NetworkError.encodingError(_) = error {
                    // Всё верно
                } else {
                    XCTFail("Ожидалась ошибка encodingError, получена: \(error)")
                }
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGet_NetworkError() {
        // Arrange: симулируем сетевую ошибку
        let expectedError = NSError(domain: "TestDomain", code: 123, userInfo: nil)
        MockURLProtocol.requestHandler = { request in
            throw expectedError
        }
        
        let expectation = self.expectation(description: "GET network error")
        
        // Act
        let endpoint = APIEndpoint(path: "/test", method: .GET, headers: [:])
        apiService.get(endpoint: endpoint, responseType: DummyResponse.self) { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Ожидалась сетевая ошибка")
                
            case .failure(let error):
                let nsError = error as NSError
                XCTAssertEqual(nsError.domain, expectedError.domain)
                XCTAssertEqual(nsError.code, expectedError.code)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
