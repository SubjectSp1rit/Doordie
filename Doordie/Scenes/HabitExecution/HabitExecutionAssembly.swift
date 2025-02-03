//
//  HabitExecutionAssembly.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

enum HabitExecutionAssembly {
    static func build(habit: Habit) -> UIViewController {
        let presenter = HabitExecutionPresenter()
        let interactor = HabitExecutionInteractor(presenter: presenter)
        let view = HabitExecutionViewController(interactor: interactor, habit: habit)
        presenter.view = view
        
        return view
    }
}
