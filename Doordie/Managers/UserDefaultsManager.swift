//
//  UserDefaultsManager.swift
//  Doordie
//
//  Created by Arseniy on 25.03.2025.
//

import Foundation

final class UserDefaultsManager {
    // MARK: - Constants
    static let shared = UserDefaultsManager()
    
    private enum Keys {
        static let authToken = "authToken"
    }
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Token Management
    var authToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.authToken)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.authToken)
        }
    }
    
    // MARK: - Methods
    func clearAuthToken() {
        UserDefaults.standard.removeObject(forKey: Keys.authToken)
    }
}
