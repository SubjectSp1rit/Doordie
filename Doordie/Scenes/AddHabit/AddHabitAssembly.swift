//
//  AddHabitAssembly.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum AddHabitAssembly {
    static func build(with habit: HabitModel? = nil) -> UIViewController {
        let presenter = AddHabitPresenter()
        let worker = AddHabitWorker()
        let interactor = AddHabitInteractor(presenter: presenter, worker: worker)
        let view = AddHabitViewController(interactor: interactor, habit: habit)
        presenter.view = view
        
        return view
    }
}
