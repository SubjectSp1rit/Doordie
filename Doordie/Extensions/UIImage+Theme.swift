//
//  UIImage+Theme.swift
//  Doordie
//
//  Created by Arseniy on 11.01.2025.
//

import UIKit

extension UIImage {
    // sets image tint color according given user's iOS theme
    func getWithTint(for theme: UIUserInterfaceStyle) -> UIImage {
        switch theme {
            
        case .dark:
            withTintColor(.white, renderingMode: .alwaysOriginal)
            
        case .light:
            withTintColor(.black, renderingMode: .alwaysOriginal)
            
        default:
            withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }
}
