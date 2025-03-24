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
    private let worker: HomeWorker
    
    // MARK: - Properties
    private var isLoading: Bool = false
    internal var habits: [HabitModel] = [] {
        didSet {
            presenter.presentHabits(HomeModels.FetchAllHabits.Response())
        }
    }

    // MARK: - Lifecycle
    init(presenter: HomePresentationLogic, worker: HomeWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public Methods
    func fetchAllHabits(_ request: HomeModels.FetchAllHabits.Request) {
        // Если данные уже загружаются - ничего не делаем
        guard !isLoading else { return }
        isLoading = true
        
        DispatchQueue.global().async {
            self.worker.fetchHabits { [weak self] isSuccess, habits, message in
                DispatchQueue.main.async {
                    if isSuccess {
                        print("Привычки успешно получены")
                        guard let habits = habits else { return }
                        self?.habits = habits
                        self?.isLoading = false
                    } else {
                        print("Ошибка получения привычек: \(message)")
                        self?.isLoading = false
                    }
                }
            }
        }
    }
}
