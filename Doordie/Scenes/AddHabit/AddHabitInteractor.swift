//
//  AddHabitInteractor.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class AddHabitInteractor: AddHabitBusinessLogic {
    // MARK: - Constants
    private let presenter: AddHabitPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: AddHabitPresentationLogic) {
        self.presenter = presenter
    }
}
