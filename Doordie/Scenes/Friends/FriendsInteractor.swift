//
//  FriendsInteractor.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class FriendsInteractor: FriendsBusinessLogic {
    // MARK: - Constants
    private let presenter: FriendsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: FriendsPresentationLogic) {
        self.presenter = presenter
    }
}
