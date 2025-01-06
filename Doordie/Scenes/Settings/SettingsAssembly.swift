//
//  SettingsAssembly.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum SettingsAssembly {
    static func build() -> UIViewController {
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(presenter: presenter)
        let view = SettingsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
