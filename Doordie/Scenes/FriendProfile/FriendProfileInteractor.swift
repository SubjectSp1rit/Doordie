//
//  FriendProfileInteractor.swift
//  Doordie
//
//  Created by Arseniy on 05.04.2025.
//

final class FriendProfileInteractor: FriendProfileBusinessLogic {
    // MARK: - Constants
    private let presenter: FriendProfilePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: FriendProfilePresentationLogic) {
        self.presenter = presenter
    }
}
