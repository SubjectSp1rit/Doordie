//
//  LoginAssembly.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

enum LoginAssembly {
    static func build(email: String? = nil) -> UIViewController {
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter)
        let view = LoginViewController(interactor: interactor, email: email)
        presenter.view = view
        
        return view
    }
}
