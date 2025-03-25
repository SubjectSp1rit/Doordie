//
//  RegistrationPasswordPresenter.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationPasswordPresenter: RegistrationPasswordPresentationLogic {
    // MARK: - Properties
    weak var view: RegistrationPasswordViewController?
    
    // MARK: - Methods
    func presentCreateAccount(_ response: RegistrationPasswordModels.CreateAccount.Response) {
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate {

            let customTabBarController = CustomTabBarController()
            sceneDelegate.changeRootViewController(customTabBarController)
        }
    }
}
