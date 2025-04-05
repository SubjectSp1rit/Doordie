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
}
