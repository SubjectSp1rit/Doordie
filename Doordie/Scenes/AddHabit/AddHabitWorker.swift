//
//  AddHabitWorker.swift
//  Doordie
//
//  Created by Arseniy on 23.03.2025.
//

import Foundation

final class AddHabitWorker {
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
    func updateHabit(_ habit: HabitModel, completion: @escaping (Bool, String) -> Void) {
        guard let url = getUrl(of: .habits) else {
            completion(false, "Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(habit)
            request.httpBody = jsonData
        } catch {
            completion(false, "Ошибка кодирования данных: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(false, "Ошибка запроса: \(error.localizedDescription)")
                return
            }
            
            completion(true, "Привычка успешно обновлена")
        }
        task.resume()
    }
    
    // MARK: - Private Methods
    private func getUrl(of type: APIRequestType) -> URL? {
        let url: String = "http://localhost:8000/habits"
        return URL(string: url)
    }
}
