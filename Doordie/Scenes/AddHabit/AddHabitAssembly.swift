//
//  AddHabitAssembly.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum AddHabitAssembly {
    static func build() -> UIViewController {
        let presenter = AddHabitPresenter()
        let interactor = AddHabitInteractor(presenter: presenter)
        let view = AddHabitViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
