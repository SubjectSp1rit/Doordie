//
//  LoginWorker.swift
//  Doordie
//
//  Created by Arseniy on 28.03.2025.
//

import UIKit

final class LoginWorker {
    // MARK: - Constants
    private enum RequestType: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    private enum APIRequestType: String {
        case email = "emails"
    }
    
    // MARK: - Properties
    private var decoder: JSONDecoder = JSONDecoder()
    private var encoder: JSONEncoder = JSONEncoder()
    
    // MARK: - Methods
    func checkEmailExists(email: String, completion: @escaping (Bool, LoginModels.IsEmailExists?, String) -> Void) {
        guard let url = getUrl(of: .email) else {
            completion(false, nil, "Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(LoginModels.Email(email: email))
            request.httpBody = jsonData
        } catch {
            completion(false, nil, "Ошибка кодирования данных: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, nil, "Ошибка запроса: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(false, nil, "Нет данных")
                return
            }
            
            do {
                let isExists = try JSONDecoder().decode(LoginModels.IsEmailExists?.self, from: data)
                completion(true, isExists, "Данные получены")
            } catch {
                completion(false, nil, "Ошибка декодирования данных: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func loginUser(_ user: User, completion: @escaping (Bool, LoginModels.LoginResponse?, String) -> Void) {
        guard let url = URL(string: "http://localhost:8000/login") else {
            completion(false, nil, "Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            completion(false, nil, "Ошибка кодирования данных: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, nil, "Ошибка запроса: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(false, nil, "Нет данных")
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginModels.LoginResponse.self, from: data)
                completion(true, loginResponse, "Данные получены")
            } catch {
                completion(false, nil, "Ошибка декодирования данных: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // MARK: - Private Methods
    private func getUrl(of type: APIRequestType) -> URL? {
        let url: String = "http://localhost:8000/emails"
        return URL(string: url)
    }
}
