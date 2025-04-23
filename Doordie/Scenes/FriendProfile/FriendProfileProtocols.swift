//
//  FriendProfileProtocols.swift
//  Doordie
//
//  Created by Arseniy on 05.04.2025.
//

protocol FriendProfileBusinessLogic {
    func fetchAllHabits(_ request: FriendProfileModels.FetchAllHabitsAnalytics.Request)
}

protocol FriendProfilePresentationLogic {
    func presentHabits(_ response: FriendProfileModels.FetchAllHabitsAnalytics.Response)
    func retryFetchHabits(_ response: FriendProfileModels.FetchAllHabitsAnalytics.Response)
}
