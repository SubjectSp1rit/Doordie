//
//  HabitExecutionModels.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

enum HabitExecutionModels {
    enum ShowDeleteConfirmationMessage {
        struct Request {
            var habit: HabitModel
        }
        struct Response {
            var habit: HabitModel
        }
        struct ViewModel { }
    }
    
    enum ShowEditHabitScreen {
        struct Request {
            var habit: HabitModel
        }
        struct Response {
            var habit: HabitModel
        }
        struct ViewModel { }
    }
    
    enum DeleteHabit {
        struct Request {
            var habit: HabitModel
        }
        struct Response {
            
        }
        struct ViewModel { }
    }
    
    enum UpdateHabitExecution {
        struct Request {
            var habit: HabitModel
            var onDismiss: () -> Void
        }
    }
    
    struct DeleteHabitResponse: Decodable {
        var detail: String?
    }
    
    struct UpdateHabitResponse: Decodable {
        var detail: String?
    }
}
