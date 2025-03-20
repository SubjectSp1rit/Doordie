//
//  RegistrationPasswordAssembly.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

enum RegistrationPasswordAssembly {
    static func build(email: String, name: String) -> UIViewController {
        let presenter = RegistrationPasswordPresenter()
        let interactor = RegistrationPasswordInteractor(presenter: presenter)
        let view = RegistrationPasswordViewController(interactor: interactor, email: email, name: name)
        presenter.view = view
        
        return view
    }
}
