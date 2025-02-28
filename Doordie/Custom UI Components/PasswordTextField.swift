//
//  PasswordTextField.swift
//  Doordie
//
//  Created by Arseniy on 28.02.2025.
//

import UIKit

class UIPasswordTextField: UITextField {
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }

    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }

}
