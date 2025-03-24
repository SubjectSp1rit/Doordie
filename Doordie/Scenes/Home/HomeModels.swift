//
//  HomeModels.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

enum HomeModels {
    enum FetchAllHabits {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    enum RouteToHabitExecutionScreen {
        struct Request {
            var habit: HabitModel
        }
        struct Response {
            var habit: HabitModel
        }
        struct ViewModel { }
    }
    
    enum RouteToAddHabitScreen {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
