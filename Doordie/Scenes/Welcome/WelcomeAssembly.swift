//
//  WelcomeAssembly.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

enum WelcomeAssembly {
    static func build() -> UIViewController {
        let presenter = WelcomePresenter()
        let interactor = WelcomeInteractor(presenter: presenter)
        let view = WelcomeViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
