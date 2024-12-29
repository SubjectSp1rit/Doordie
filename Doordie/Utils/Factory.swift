//
//  Factory.swift
//  Doordie
//
//  Created by Arseniy on 29.12.2024.
//

import Foundation
import UIKit

final class Factory {
    // MARK: - Singleton
    static let shared = Factory()
    
    private init () { }
    
    // MARK: - Public Methods
    func createLabel(text: String = "",
                     color: UIColor = .clear,
                     alignment: NSTextAlignment = .left,
                     size: CGFloat = 17,
                     weight: UIFont.Weight = .regular,
                     numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = alignment
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.numberOfLines = numberOfLines
        return label
    }
    
    func createView(backgroundColor: UIColor = .clear,
                    cornerRadius: CGFloat = 0,
                    shadowColor: UIColor? = nil,
                    shadowOpacity: Float = 0,
                    shadowOffsetX: CGFloat = 0,
                    shadowOffsetY: CGFloat = 0,
                    shadowRadius: CGFloat = 0,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat = 0) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        
        // Тень
        if let shadowColor = shadowColor {
            view.layer.shadowColor = shadowColor.cgColor
            view.layer.shadowOpacity = shadowOpacity
            view.layer.shadowOffset = CGSize(width: shadowOffsetX ,height: shadowOffsetY)
            view.layer.shadowRadius = shadowRadius
            view.layer.masksToBounds = false
        }
        
        // Граница
        if let borderColor = borderColor {
            view.layer.borderColor = borderColor.cgColor
            view.layer.borderWidth = borderWidth
        }
        
        return view
    }
}
