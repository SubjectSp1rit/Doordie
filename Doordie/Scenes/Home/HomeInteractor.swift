//
//  HomeInteractor.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

final class HomeInteractor: HomeBusinessLogic {
    // MARK: - Constants
    private let presenter: HomePresentationLogic
    private let worker = HomeWorker()

    // MARK: - Lifecycle
    init(presenter: HomePresentationLogic) {
        self.presenter = presenter
    }
}
