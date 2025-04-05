//
//  FriendProfileAssembly.swift
//  Doordie
//
//  Created by Arseniy on 05.04.2025.
//

import UIKit

enum FriendProfileAssembly {
    static func build(email: String, name: String) -> UIViewController {
        let presenter = FriendProfilePresenter()
        let interactor = FriendProfileInteractor(presenter: presenter)
        let view = FriendProfileViewController(interactor: interactor, email: email, name: name)
        presenter.view = view
        
        return view
    }
}
