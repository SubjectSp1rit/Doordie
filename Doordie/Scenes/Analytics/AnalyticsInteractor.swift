//
//  AnalyticsInteractor.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class AnalyticsInteractor: AnalyticsBusinessLogic {
    // MARK: - Constants
    private let presenter: AnalyticsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: AnalyticsPresentationLogic) {
        self.presenter = presenter
    }
}
