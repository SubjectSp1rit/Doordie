//
//  String+IsValidEmail.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import Foundation

extension String {
    /// Проверяет, является ли строка валидным e-mail
    /// - Returns: `true`, если e-mail корректный, иначе `false`
    func isValidEmail() -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
