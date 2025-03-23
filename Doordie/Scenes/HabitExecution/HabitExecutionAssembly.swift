//
//  HabitExecutionAssembly.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

enum HabitExecutionAssembly {
    static func build(habit: HabitModel) -> UIViewController {
        let presenter = HabitExecutionPresenter()
        let worker = HabitExecutionWorker()
        let interactor = HabitExecutionInteractor(presenter: presenter, worker: worker)
        let view = HabitExecutionViewController(interactor: interactor, habit: habit)
        presenter.view = view
        
        return view
    }
}
