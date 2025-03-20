//
//  EmailCodeAssembly.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

enum RegistrationEmailCodeAssembly {
    static func build(email: String) -> UIViewController {
        let presenter = RegistrationEmailCodePresenter()
        let interactor = RegistrationEmailCodeInteractor(presenter: presenter)
        let view = RegistrationEmailCodeViewController(interactor: interactor, email: email)
        presenter.view = view
        
        return view
    }
}
