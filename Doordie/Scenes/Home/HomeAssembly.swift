//
//  HomeAssembly.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

enum HomeAssembly {
    static func build() -> UIViewController {
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter)
        let view = HomeViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
