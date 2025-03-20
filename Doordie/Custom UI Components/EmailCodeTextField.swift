//
//  EmailCodeTextField.swift
//  Doordie
//
//  Created by Arseniy on 19.03.2025.
//

import UIKit

// how to use: внутри VC, где нужно использовать текстовое поле, создать его экземпляр и установить делегатом self

protocol EmailCodeTextFieldDelegate: AnyObject {
    func didPressBackspace(_ textField: EmailCodeTextField)
}

// Кастомное текстовое поле, которое отслеживает нажатие клавиши удаления
final class EmailCodeTextField: UITextField {
    weak var backspaceDelegate: EmailCodeTextFieldDelegate?
    
    override func deleteBackward() {
        // Tекущее положение курсора
        if let selectedRange = self.selectedTextRange,
           selectedRange.start == self.beginningOfDocument {
            // Если курсор в начале, а поле не пустое – удаляем текущий символ
            if let text = self.text, !text.isEmpty {
                self.text = ""
            }
            // Уведомляем делегата, чтобы перевести фокус на предыдущее поле
            backspaceDelegate?.didPressBackspace(self)
        } else {
            // В остальных случаях вызываем стандартное поведение
            super.deleteBackward()
        }
    }
}
