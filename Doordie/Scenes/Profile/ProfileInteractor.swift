//
//  ProfileInteractor.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

final class ProfileInteractor: ProfileBusinessLogic {
    // MARK: - Constants
    private let presenter: ProfilePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: ProfilePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func routeToAddFriendScreen(_ request: ProfileModels.RouteToAddFriendScreen.Request) {
        presenter.routeToAddFriendScreen(ProfileModels.RouteToAddFriendScreen.Response())
    }
}
