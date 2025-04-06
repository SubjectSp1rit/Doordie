//
//  AnalyticsPresenter.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class AnalyticsPresenter: AnalyticsPresentationLogic {
    // MARK: - Variables
    weak var view: AnalyticsViewController?
    
    // MARK: - Methods
    func presentHabits(_ response: AnalyticsModels.FetchAllHabitsAnalytics.Response) {
        view?.displayUpdatedHabits(HomeModels.FetchAllHabits.ViewModel())
    }
}
