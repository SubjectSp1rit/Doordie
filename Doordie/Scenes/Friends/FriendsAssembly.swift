//
//  FriendsAssembly.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum FriendsAssembly {
    static func build() -> UIViewController {
        let presenter = FriendsPresenter()
        let interactor = FriendsInteractor(presenter: presenter)
        let view = FriendsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
