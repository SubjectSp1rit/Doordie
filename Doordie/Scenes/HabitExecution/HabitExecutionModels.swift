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
            var habit: Habit
        }
        struct Response {
            var habit: Habit
        }
        struct ViewModel { }
    }
    
    enum ShowEditHabitScreen {
        struct Request {
            var habit: Habit
        }
        struct Response {
            var habit: Habit
        }
    }
}
