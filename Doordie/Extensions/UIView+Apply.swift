//
//  UIView+Apply.swift
//  Doordie
//
//  Created by Arseniy on 07.02.2025.
//

import UIKit

extension UIView {
    func apply(_ style: Style?) {
        guard let style else { return }
        layer.cornerRadius = style.cornerRadius
        backgroundColor = UIColor(hex: style.backgroundColor)
    }
}
