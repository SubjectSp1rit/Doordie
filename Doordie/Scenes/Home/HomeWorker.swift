//
//  HomeWorker.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

final class HomeWorker {
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
    func fetchHabits(completion: @escaping (Bool, [HabitModel]?, String) -> Void) {
        guard let url = getUrl(of: .habits) else {
            completion(false, nil, "Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                let habits = try JSONDecoder().decode([HabitModel].self, from: data)
                completion(true, habits, "Данные получены")
            } catch {
                completion(false, nil, "Ошибка декодирования данных: \(error.localizedDescription)")
                
            }
        }
        task.resume()
    }
    
    // MARK: - Private Methods
    private func getUrl(of type: APIRequestType) -> URL? {
        let url: String = "http://localhost:8000/habits"
        return URL(string: url)
    }
}
