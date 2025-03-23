//
//  HabitModel.swift
//  Doordie
//
//  Created by Arseniy on 22.03.2025.
//

import Foundation

struct HabitModel: Codable {
    var id: Int? = nil
    let creation_date: String?
    let title: String?
    let motivations: String?
    let color: String?
    let icon: String?
    let quantity: String?
    let current_quantity: String?
    let measurement: String?
    let regularity: String?
    let day_part: String?
    
    // Инициализатор, который принимает дату типа Date
    init(
        id: Int? = nil,
        creationDate: Date,
        title: String?,
        motivations: String?,
        color: String?,
        icon: String?,
        quantity: String?,
        currentQuantity: String?,
        measurement: String?,
        regularity: String?,
        dayPart: String?
    ) {
        self.id = id
        self.creation_date = HabitModel.dateFormatter.string(from: creationDate)
        self.title = title
        self.motivations = motivations
        self.color = color
        self.icon = icon
        self.quantity = quantity
        self.current_quantity = currentQuantity
        self.measurement = measurement
        self.regularity = regularity
        self.day_part = dayPart
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}
