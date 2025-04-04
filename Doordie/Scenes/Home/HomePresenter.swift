//
//  HomePresenter.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

final class HomePresenter: HomePresentationLogic {
    // MARK: - Properties
    weak var view: HomeViewController?
    
    // MARK: - Public Methods
    func presentHabits(_ response: HomeModels.FetchAllHabits.Response) {
        view?.displayUpdatedHabits(HomeModels.FetchAllHabits.ViewModel())
    }
    
    func routeToHabitExecutionScreen(_ response: HomeModels.RouteToHabitExecutionScreen.Response) {
        let habitExecutionVC = HabitExecutionAssembly.build(habit: response.habit, onDismiss: response.onDismiss)
        let navController = UINavigationController(rootViewController: habitExecutionVC)
        navController.modalPresentationStyle = .overFullScreen
        
        view?.present(navController, animated: true, completion: nil)
    }
    
    func routeToAddHabitScreen(_ response: HomeModels.RouteToAddHabitScreen.Response) {
        let addHabitVC = AddHabitAssembly.build()
        let navController = UINavigationController(rootViewController: addHabitVC)
        navController.modalPresentationStyle = .overFullScreen
        
        view?.present(navController, animated: true, completion: nil)
    }
    
    func routeToProfileScreen(_ response: HomeModels.RouteToProfileScreen.Response) {
        let profileVC = ProfileAssembly.build()
        profileVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(profileVC, animated: true)
    }
}
