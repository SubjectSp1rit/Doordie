//
//  HabitExecutionAssembly.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

enum HabitExecutionAssembly {
    static func build(habit: HabitModel, onDismiss: @escaping () -> Void) -> UIViewController {
        let presenter = HabitExecutionPresenter()
        let interactor = HabitExecutionInteractor(presenter: presenter)
        let view = HabitExecutionViewController(interactor: interactor, habit: habit, onDismiss: onDismiss)
        presenter.view = view
        
        return view
    }
}
