//
//  HabitExecutionAssembly.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

enum HabitExecutionAssembly {
    static func build() -> UIViewController {
        let presenter = HabitExecutionPresenter()
        let interactor = HabitExecutionInteractor(presenter: presenter)
        let view = HabitExecutionViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
