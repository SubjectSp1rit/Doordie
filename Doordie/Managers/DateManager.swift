//
//  DateManager.swift
//  Doordie
//
//  Created by Arseniy on 24.03.2025.
//

import Foundation

final class DateManager {
    // MARK: - Constants
    static let shared = DateManager()
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    final func getLocalizedMonthAndDay() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        // Язык системы
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
        
        // Ставим подходящую локаль
        if preferredLanguage.starts(with: "ru") {
            formatter.locale = Locale(identifier: "ru_RU")
        } else {
            formatter.locale = Locale(identifier: "en_US")
        }
        
        formatter.dateFormat = "LLLL d"
        return formatter.string(from: date).capitalized
    }
}
