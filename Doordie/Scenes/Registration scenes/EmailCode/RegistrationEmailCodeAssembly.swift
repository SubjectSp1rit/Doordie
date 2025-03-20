//
//  EmailCodeAssembly.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

enum RegistrationEmailCodeAssembly {
    static func build() -> UIViewController {
        let presenter = RegistrationEmailCodePresenter()
        let interactor = RegistrationEmailCodeInteractor(presenter: presenter)
        let view = RegistrationEmailCodeViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
