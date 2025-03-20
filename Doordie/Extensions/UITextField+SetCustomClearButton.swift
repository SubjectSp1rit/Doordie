//
//  UITextField+SetCustomClearButton.swift
//  Doordie
//
//  Created by Arseniy on 28.02.2025.
//

import UIKit

extension UITextField {

    /// Устанавливает кастомную кнопку очистки с заданным цветом и режимом отображения.
    /// - Parameters:
    ///   - mode: Режим отображения кнопки очистки (`.never`, `.whileEditing`, `.unlessEditing`, `.always`).
    ///   - color: Цвет кнопки очистки.
    func setCustomClearButton(mode: UITextField.ViewMode, color: UIColor, padding: CGFloat) {
        let clearButton = UIButton(type: .custom)
        let clearImage = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        clearButton.setImage(clearImage, for: .normal)
        clearButton.tintColor = color
        clearButton.addAction(UIAction(handler: { [weak self] _ in
            self?.text = ""
            self?.sendActions(for: .editingChanged)
        }), for: .touchUpInside)

        clearButton.imageView?.contentMode = .scaleAspectFit
        clearButton.contentHorizontalAlignment = .center
        clearButton.contentVerticalAlignment = .center

        // Размер кнопки
        let buttonSize: CGFloat = 24
        clearButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)

        // Контейнер для отступа кнопки
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: buttonSize + padding, height: buttonSize))
        clearButton.center = containerView.center
        containerView.addSubview(clearButton)
        
        clearButtonMode = .never
        rightViewMode = .always
        rightView = containerView
    }
}

