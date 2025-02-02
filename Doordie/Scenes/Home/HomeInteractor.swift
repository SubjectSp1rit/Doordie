//
//  HomeInteractor.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

final class HomeInteractor: HomeBusinessLogic, HabitsStorage {
    // MARK: - Constants
    private let presenter: HomePresentationLogic
    private let worker = HomeWorker()
    
    // MARK: - Properties
    internal var habits: [Habit] = [] {
        didSet {
            presenter.presentHabits(HomeModels.LoadHabits.Response())
        }
    }

    // MARK: - Lifecycle
    init(presenter: HomePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func loadHabits(_ request: HomeModels.LoadHabits.Request) {
        habits = CoreManager.shared.fetchAllHabits()
    }
}
