//
//  HomeModels.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

enum HomeModels {
    enum LoadHabits {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}

struct HabitModel {
    var creationDate: Date?
    var title: String?
    var motivations: String?
    var color: String?
    var icon: String?
    var quantity: String?
    var currentQuantity: String?
    var measurement: String?
    var regularity: String?
    var dayPart: String?
}
