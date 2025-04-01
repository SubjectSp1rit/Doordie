//
//  DateManager.swift
//  Doordie
//
//  Created by Arseniy on 24.03.2025.
//

import Foundation

struct DayInfo {
    let date: Date
    let dayNumber: String
    let weekDay: String
}

final class DateManager {
    // MARK: - Constants
    static let shared = DateManager()
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func getLocalizedMonthAndDay() -> String {
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
    
    func getDaysInfo(daysBackward: Int = 30, daysForward: Int = 30) -> [DayInfo] {
        let calendar = Calendar.current
        let today = Date()
        
        // Формируем диапазон дат
        let startDate = calendar.date(byAdding: .day, value: -daysBackward, to: today)!
        let endDate = calendar.date(byAdding: .day, value: daysForward, to: today)!
        
        var dates: [DayInfo] = []
        var currentDate = startDate
        
        let numberFormatter = DateFormatter()
        numberFormatter.dateFormat = "d"
        
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.dateFormat = "E"
        
        // Ставим подходящую локаль
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
        let locale = preferredLanguage.starts(with: "ru") ? Locale(identifier: "ru_RU") : Locale(identifier: "en_US")
        numberFormatter.locale = locale
        weekDayFormatter.locale = locale
        
        // Генерируем массив дат
        while currentDate <= endDate {
            let dayInfo = DayInfo(
                date: currentDate,
                dayNumber: numberFormatter.string(from: currentDate),
                weekDay: weekDayFormatter.string(from: currentDate)
            )
            dates.append(dayInfo)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    // Проверяет, является ли дата сегодняшней
    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
}
