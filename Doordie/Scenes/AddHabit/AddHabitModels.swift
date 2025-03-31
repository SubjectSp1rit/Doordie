//
//  AddHabitModels.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum AddHabitModels {
    enum UpdateHabit {
        struct Request {
            var habit: HabitModel
        }
        struct Response { }
        struct ViewModel { }
    }
    
    enum CreateHabit {
        struct Request {
            var habit: HabitModel
        }
        struct Response { }
        struct ViewModel { }
    }
    
    struct UpdateHabitResponse: Decodable {
        var detail: String?
    }
    
    struct CreateHabitResponse: Decodable {
        var detail: String?
    }
}

