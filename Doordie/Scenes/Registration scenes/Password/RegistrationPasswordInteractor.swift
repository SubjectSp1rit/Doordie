//
//  RegistrationPasswordInteractor.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationPasswordInteractor: RegistrationPasswordBusinessLogic {
    // MARK: - Constants
    private let presenter: RegistrationPasswordPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationPasswordPresentationLogic) {
        self.presenter = presenter
    }
}
