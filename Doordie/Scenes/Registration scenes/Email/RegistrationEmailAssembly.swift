//
//  RegistrationEmailAssembly.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

enum RegistrationEmailAssembly {
    static func build() -> UIViewController {
        let presenter = RegistrationEmailPresenter()
        let interactor = RegistrationEmailInteractor(presenter: presenter)
        let view = RegistrationEmailViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
