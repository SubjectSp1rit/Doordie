//
//  EmailCodeInteractor.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

final class RegistrationEmailCodeInteractor: RegistrationEmailCodeBusinessLogic {
    // MARK: - Constants
    private let presenter: RegistrationEmailCodePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationEmailCodePresentationLogic) {
        self.presenter = presenter
    }
}
