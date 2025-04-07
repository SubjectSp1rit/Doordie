//
//  MotivationsManager.swift
//  Doordie
//
//  Created by Arseniy on 07.04.2025.
//

import Foundation

final class MotivationsManager {
    // MARK: - Constants
    static let shared = MotivationsManager()
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func motivationalPhrase(for percentage: Int) -> String {
        switch percentage {
        case 0..<20:
            return "Begin Now!"
        case 20..<40:
            return "Keep Going!"
        case 40..<60:
            return "Halfway There!"
        case 60..<80:
            return "Your daily goals almost done!"
        case 80..<100:
            return "Nearly There!"
        case 100:
            return "Well Done!"
        default:
            return "Invalid Percentage"
        }
    }
}
