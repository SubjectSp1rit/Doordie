//
//  Networking.swift
//  Doordie
//
//  Created by Arseniy on 30.03.2025.
//

import UIKit

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case encodingError(Error)
    case decodingError(Error)
    case invalidMethodForBody
}

struct APIEndpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]? = ["Content-Type": "application/json"]
    let queryParameters: [String: String]? = nil
}

protocol APIServiceProtocol {
    func send<T: Decodable, U: Encodable>(
        endpoint: APIEndpoint,
        body: U,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
    
    func get<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void)
}

final class APIService: APIServiceProtocol {
    // MARK: - Constants
    private let baseURL: String
    
    // MARK: - Lifecycle
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // MARK: - Methods
    
    // Метод для запросов, где тело допустимо только с POST, PUT, DELETE
    func send<T: Decodable, U: Encodable>(
        endpoint: APIEndpoint,
        body: U,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        // Если метод GET – ошибка, так как GET недопустим
        guard endpoint.method != .GET else {
            completion(.failure(NetworkError.invalidMethodForBody))
            return
        }

        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlComponents.path += endpoint.path
        
        if let params = endpoint.queryParameters {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(NetworkError.encodingError(error)))
            return
        }
        
        sendRequest(with: request, responseType: responseType, completion: completion)
    }
    
    func get<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlComponents.path += endpoint.path
        
        if let params = endpoint.queryParameters {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        sendRequest(with: request, responseType: responseType, completion: completion)
    }
    
    // MARK: - Private Methods
    
    // Базовый метод, в котором инкапсулирована логика отправки запроса
    private func sendRequest<T: Decodable>(
        with request: URLRequest,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
