//
//  ExtendedHitButton.swift
//  Doordie
//
//  Created by Arseniy on 13.02.2025.
//

import UIKit

class ExtendedHitButton: UIButton {
    /// Определяем отступы для расширения области. Значения отрицательные, чтобы увеличить область.
    var hitTestEdgeInsets = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -15)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // Расширяем рамки кнопки за счет заданных отступов
        let extendedBounds = bounds.inset(by: hitTestEdgeInsets)
        return extendedBounds.contains(point)
    }
}
