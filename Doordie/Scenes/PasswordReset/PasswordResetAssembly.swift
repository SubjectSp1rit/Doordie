//
//  PasswordResetAssembly.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

enum PasswordResetAssembly {
    static func build(email: String? = nil) -> UIViewController {
        let presenter = PasswordResetPresenter()
        let interactor = PasswordResetInteractor(presenter: presenter)
        let view = PasswordResetViewController(interactor: interactor, email: email)
        presenter.view = view
        
        return view
    }
}
