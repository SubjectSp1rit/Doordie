//
//  HabitTitleCell.swift
//  Doordie
//
//  Created by Arseniy on 08.01.2025.
//

import Foundation
import UIKit

final class HabitTitleCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitTitleLabel {
            static let text: String = "Habit title"
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
        }
        
        enum HabitTitleTextField {
            static let height: CGFloat = 50
            static let topIndent: CGFloat = 5
            static let bgColor: UIColor = UIColor(hex: "5771DB").withAlphaComponent(0.7)
            static let cornerRadius: CGFloat = 14
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 22
            static let keyboardType: UIKeyboardType = .default
            static let autocorrectioType: UITextAutocorrectionType = .default
            static let autocapitalizationType: UITextAutocapitalizationType = .sentences
            static let clearButtonMode: UITextField.ViewMode = .always
            static let textAlignment: NSTextAlignment = .left
            static let leftTextPadding: CGFloat = 8
            static let minimumBorderWidth: CGFloat = 0
            static let maximumBorderWidth: CGFloat = 2
            static let borderColor: CGColor = UIColor.systemRed.cgColor
        }
    }
    
    static let reuseId: String = "HabitTitleCell"
    
    // MARK: - UI Components
    private let habitTitleLabel: UILabel = UILabel()
    private let habitTitleTextField: UITextField = UITextField()
    
    // MARK: - Properties
    var onTitleChanged: ((String) -> Void)?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureHabitTitleLabel()
        configureHabitTitleTextField()
    }
    
    private func configureHabitTitleLabel() {
        contentView.addSubview(habitTitleLabel)
        
        habitTitleLabel.text = Constants.HabitTitleLabel.text
        habitTitleLabel.textColor = Constants.HabitTitleLabel.textColor
        habitTitleLabel.textAlignment = Constants.HabitTitleLabel.textAlignment
        
        habitTitleLabel.pinTop(to: contentView.topAnchor)
        habitTitleLabel.pinLeft(to: contentView.leadingAnchor)
        habitTitleLabel.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitTitleTextField() {
        contentView.addSubview(habitTitleTextField)
        
        habitTitleTextField.textColor = Constants.HabitTitleTextField.textColor
        habitTitleTextField.font = UIFont.systemFont(ofSize: Constants.HabitTitleTextField.fontSize)
        habitTitleTextField.backgroundColor = Constants.HabitTitleTextField.bgColor
        habitTitleTextField.layer.cornerRadius = Constants.HabitTitleTextField.cornerRadius
        habitTitleTextField.keyboardType = Constants.HabitTitleTextField.keyboardType
        habitTitleTextField.autocorrectionType = Constants.HabitTitleTextField.autocorrectioType
        habitTitleTextField.autocapitalizationType = Constants.HabitTitleTextField.autocapitalizationType
        habitTitleTextField.clearButtonMode = Constants.HabitTitleTextField.clearButtonMode
        habitTitleTextField.textAlignment = Constants.HabitTitleTextField.textAlignment
        habitTitleTextField.setLeftPadding(left: Constants.HabitTitleTextField.leftTextPadding)
        habitTitleTextField.layer.borderColor = Constants.HabitTitleTextField.borderColor
        
        habitTitleTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        habitTitleTextField.setHeight(Constants.HabitTitleTextField.height)
        habitTitleTextField.pinTop(to: habitTitleLabel.bottomAnchor, Constants.HabitTitleTextField.topIndent)
        habitTitleTextField.pinBottom(to: contentView.bottomAnchor)
        habitTitleTextField.pinLeft(to: contentView.leadingAnchor)
        habitTitleTextField.pinRight(to: contentView.trailingAnchor)
    }
    
    // MARK: - Actions
    @objc
    private func textDidChange() {
        habitTitleTextField.layer.borderWidth = Constants.HabitTitleTextField.minimumBorderWidth
        
        let text = habitTitleTextField.text
        onTitleChanged?(text ?? "")
    }
}
