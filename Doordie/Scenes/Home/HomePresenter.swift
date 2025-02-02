//
//  HomePresenter.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

final class HomePresenter: HomePresentationLogic {
    // MARK: - Variables
    weak var view: HomeViewController?
    
    // MARK: - Public Methods
    func presentHabits(_ response: HomeModels.LoadHabits.Response) {
        view?.displayUpdatedHabits(HomeModels.LoadHabits.ViewModel())
    }
}
