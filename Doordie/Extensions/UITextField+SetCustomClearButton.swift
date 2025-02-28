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
    func setCustomClearButton(mode: UITextField.ViewMode, color: UIColor) {
        let clearButton = UIButton(type: .custom)
        let clearImage = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        clearButton.setImage(clearImage, for: .normal)
        clearButton.tintColor = color
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)

        clearButton.imageView?.contentMode = .scaleAspectFit
        clearButton.contentHorizontalAlignment = .center
        clearButton.contentVerticalAlignment = .center

        // Размер кнопки
        let buttonSize: CGFloat = 24
        clearButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)

        // Контейнер для отступа кнопки
        let padding: CGFloat = 8
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: buttonSize + padding, height: buttonSize))
        clearButton.center = containerView.center
        containerView.addSubview(clearButton)

        rightView = containerView
        rightViewMode = mode
    }

    @objc private func clearText() {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}

