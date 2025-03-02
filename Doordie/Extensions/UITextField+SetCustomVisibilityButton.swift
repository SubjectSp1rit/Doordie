//
//  UITextField+SetCustomVisibilityButton.swift
//  Doordie
//
//  Created by Arseniy on 28.02.2025.
//

import UIKit

extension UITextField {
    
    /// Устанавливает кастомную кнопку видимости пароля
    /// - Parameter padding: Отступ от правого края
    func setCustomVisibilityButton(mode: UITextField.ViewMode, color: UIColor, padding: CGFloat) {
        let visibilityButton: UIButton = UIButton(type: .custom)
        let unvisibleImage: UIImage? = UIImage(systemName: "eye.fill")?.withRenderingMode(.alwaysTemplate)
        let visibleImage: UIImage? = UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysTemplate)
        visibilityButton.tintColor = color
        visibilityButton.setImage(unvisibleImage, for: .normal)
        visibilityButton.setImage(visibleImage, for: .selected)
        visibilityButton.addTarget(self, action: #selector(changeSecureMode), for: .touchUpInside)
        
        visibilityButton.imageView?.contentMode = .scaleAspectFit
        visibilityButton.contentHorizontalAlignment = .center
        visibilityButton.contentVerticalAlignment = .center
        
        // Размер кнопки
        let buttonSize: CGFloat = 24
        visibilityButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: buttonSize + padding, height: buttonSize))
        visibilityButton.center = containerView.center
        containerView.addSubview(visibilityButton)
        
        self.rightView = containerView
        self.rightViewMode = mode
    }
    
    @objc private func changeSecureMode(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
}
