//
//  FriendProfilePresenter.swift
//  Doordie
//
//  Created by Arseniy on 05.04.2025.
//

final class FriendProfilePresenter: FriendProfilePresentationLogic {
    // MARK: - Properties
    weak var view: FriendProfileViewController?
    
    // MARK: - Methods
    func presentHabits(_ response: FriendProfileModels.FetchAllHabitsAnalytics.Response) {
        view?.displayUpdatedHabits(FriendProfileModels.FetchAllHabitsAnalytics.ViewModel())
    }
    
    func retryFetchHabits(_ response: FriendProfileModels.FetchAllHabitsAnalytics.Response) {
        view?.retryFetchHabits(FriendProfileModels.FetchAllHabitsAnalytics.ViewModel())
    }
}
