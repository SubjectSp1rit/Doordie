//
//  AddFriendAssembly.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

enum AddFriendAssembly {
    static func build() -> UIViewController {
        let presenter = AddFriendPresenter()
        let interactor = AddFriendInteractor(presenter: presenter)
        let view = AddFriendViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
