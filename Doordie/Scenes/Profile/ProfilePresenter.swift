//
//  ProfilePresenter.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

final class ProfilePresenter: ProfilePresentationLogic {
    // MARK: - Properties
    weak var view: ProfileViewController?
    
    // MARK: - Methods
    func routeToAddFriendScreen(_ response: ProfileModels.RouteToAddFriendScreen.Response) {
        let addFriendVC = AddFriendAssembly.build()
        addFriendVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(addFriendVC, animated: true)
    }
    
    func routeToFriendProfileScreen(_ response: ProfileModels.RouteToFriendProfileScreen.Response) {
        let friendProfileVC = FriendProfileAssembly.build(email: response.email, name: response.name)
        friendProfileVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(friendProfileVC, animated: true)
    }
    
    func presentAllFriends(_ response: ProfileModels.FetchAllFriends.Response) {
        view?.displayFetchedFriends(ProfileModels.FetchAllFriends.ViewModel())
    }
}
