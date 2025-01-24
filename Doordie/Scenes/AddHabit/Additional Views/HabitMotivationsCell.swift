//
//  HabitMotivationsCell.swift
//  Doordie
//
//  Created by Arseniy on 10.01.2025.
//

import Foundation
import UIKit

final class HabitMotivationsCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitMotivationsLabel {
            static let text: String = "Motivations"
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
        }
        
        enum HabitTitleTextView {
            static let height: CGFloat = 100
            static let topIndent: CGFloat = 5
            static let bgColor: UIColor = UIColor(hex: "5771DB").withAlphaComponent(0.7)
            static let cornerRadius: CGFloat = 14
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 17
            static let keyboardType: UIKeyboardType = .default
            static let autocorrectioType: UITextAutocorrectionType = .default
            static let autocapitalizationType: UITextAutocapitalizationType = .sentences
            static let clearButtonMode: UITextField.ViewMode = .always
            static let textAlignment: NSTextAlignment = .left
            static let leftTextPadding: CGFloat = 8
            static let textTopIndent: CGFloat = 8
            static let textBottomIndent: CGFloat = 8
            static let textLeadingIndent: CGFloat = 8
            static let textTrailingIndent: CGFloat = 8
        }
        
        enum Wrap {
            static let bgColor: UIColor = .clear
        }
    }
    
    static let reuseId: String = "HabitMotivationsCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let habitMotivationsLabel: UILabel = UILabel()
    private let habitMotivationsTextView: UITextView = UITextView()
    
    // MARK: - Properties
    var onMotivationsChanged: ((String) -> Void)?
    
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
        configureWrap()
        configureHabitMotivationsLabel()
        configureHabitMotivationsTextView()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitMotivationsLabel() {
        wrap.addSubview(habitMotivationsLabel)
        
        habitMotivationsLabel.text = Constants.HabitMotivationsLabel.text
        habitMotivationsLabel.textColor = Constants.HabitMotivationsLabel.textColor
        habitMotivationsLabel.textAlignment = Constants.HabitMotivationsLabel.textAlignment
        
        habitMotivationsLabel.pinTop(to: wrap.topAnchor)
        habitMotivationsLabel.pinLeft(to: wrap.leadingAnchor)
        habitMotivationsLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureHabitMotivationsTextView() {
        wrap.addSubview(habitMotivationsTextView)
        
        habitMotivationsTextView.textColor = Constants.HabitTitleTextView.textColor
        habitMotivationsTextView.font = UIFont.systemFont(ofSize: Constants.HabitTitleTextView.fontSize)
        habitMotivationsTextView.backgroundColor = Constants.HabitTitleTextView.bgColor
        habitMotivationsTextView.layer.cornerRadius = Constants.HabitTitleTextView.cornerRadius
        habitMotivationsTextView.keyboardType = Constants.HabitTitleTextView.keyboardType
        habitMotivationsTextView.autocorrectionType = Constants.HabitTitleTextView.autocorrectioType
        habitMotivationsTextView.autocapitalizationType = Constants.HabitTitleTextView.autocapitalizationType
        habitMotivationsTextView.textAlignment = Constants.HabitTitleTextView.textAlignment
        habitMotivationsTextView.isEditable = true
        habitMotivationsTextView.isSelectable = true
        habitMotivationsTextView.isScrollEnabled = true
        habitMotivationsTextView.textContainerInset = UIEdgeInsets(top: Constants.HabitTitleTextView.textTopIndent, left: Constants.HabitTitleTextView.textLeadingIndent, bottom: Constants.HabitTitleTextView.textBottomIndent, right: Constants.HabitTitleTextView.textTrailingIndent)
        
        habitMotivationsTextView.delegate = self
        
        habitMotivationsTextView.setHeight(Constants.HabitTitleTextView.height)
        habitMotivationsTextView.pinTop(to: habitMotivationsLabel.bottomAnchor, Constants.HabitTitleTextView.topIndent)
        habitMotivationsTextView.pinBottom(to: wrap.bottomAnchor)
        habitMotivationsTextView.pinLeft(to: wrap.leadingAnchor)
        habitMotivationsTextView.pinRight(to: wrap.trailingAnchor)
    }
}

extension HabitMotivationsCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let text = habitMotivationsTextView.text
        onMotivationsChanged?(text ?? "")
    }
}

