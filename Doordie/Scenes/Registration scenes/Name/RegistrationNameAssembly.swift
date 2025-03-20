//
//  RegistrationNameAssembly.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

enum RegistrationNameAssembly {
    static func build(email: String) -> UIViewController {
        let presenter = RegistrationNamePresenter()
        let interactor = RegistrationNameInteractor(presenter: presenter)
        let view = RegistrationNameViewController(interactor: interactor, email: email)
        presenter.view = view
        
        return view
    }
}
