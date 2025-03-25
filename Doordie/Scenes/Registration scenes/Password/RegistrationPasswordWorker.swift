//
//  RegistrationPasswordWorker.swift
//  Doordie
//
//  Created by Arseniy on 25.03.2025.
//

import Foundation

final class RegistrationPasswordWorker {
    // MARK: - Constants
    private enum RequestType: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    private enum APIRequestType: String {
        case habits = "habits"
    }
    
    // MARK: - Properties
    private var decoder: JSONDecoder = JSONDecoder()
    private var encoder: JSONEncoder = JSONEncoder()
    
    // MARK: - Methods
    func createAccount(_ user: User, completion: @escaping (Bool, String, Token?) -> Void) {
        guard let url = getUrl(of: .habits) else {
            completion(false, "Неверный URL", nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            completion(false, "Ошибка кодирования данных: \(error.localizedDescription)", nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, "Ошибка запроса: \(error.localizedDescription)", nil)
                return
            }
            
            guard let data = data else {
                completion(false, "Ошибка: нет токена", nil)
                return
            }
            
            do {
                let token = try JSONDecoder().decode(Token.self, from: data)
                completion(true, "Пользователь успешно создан", token)
            } catch {
                completion(false, "Ошибка декодирования данных: \(error.localizedDescription)", nil)
            }
        }
        task.resume()
    }
    
    // MARK: - Private Methods
    private func getUrl(of type: APIRequestType) -> URL? {
        let url: String = "http://localhost:8000/users"
        return URL(string: url)
    }
}

