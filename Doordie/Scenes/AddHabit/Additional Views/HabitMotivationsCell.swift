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
        
        enum HabitTitleLabel {
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
    private let habitTitleLabel: UILabel = UILabel()
    private let habitTitleTextView: UITextView = UITextView()
    
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
        configureHabitTitleLabel()
        configureHabitTitleTextView()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitTitleLabel() {
        wrap.addSubview(habitTitleLabel)
        
        habitTitleLabel.text = Constants.HabitTitleLabel.text
        habitTitleLabel.textColor = Constants.HabitTitleLabel.textColor
        habitTitleLabel.textAlignment = Constants.HabitTitleLabel.textAlignment
        
        habitTitleLabel.pinTop(to: wrap.topAnchor)
        habitTitleLabel.pinLeft(to: wrap.leadingAnchor)
        habitTitleLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureHabitTitleTextView() {
        wrap.addSubview(habitTitleTextView)
        
        habitTitleTextView.textColor = Constants.HabitTitleTextView.textColor
        habitTitleTextView.font = UIFont.systemFont(ofSize: Constants.HabitTitleTextView.fontSize)
        habitTitleTextView.backgroundColor = Constants.HabitTitleTextView.bgColor
        habitTitleTextView.layer.cornerRadius = Constants.HabitTitleTextView.cornerRadius
        habitTitleTextView.keyboardType = Constants.HabitTitleTextView.keyboardType
        habitTitleTextView.autocorrectionType = Constants.HabitTitleTextView.autocorrectioType
        habitTitleTextView.autocapitalizationType = Constants.HabitTitleTextView.autocapitalizationType
        habitTitleTextView.textAlignment = Constants.HabitTitleTextView.textAlignment
        habitTitleTextView.isEditable = true
        habitTitleTextView.isSelectable = true
        habitTitleTextView.isScrollEnabled = true
        habitTitleTextView.textContainerInset = UIEdgeInsets(top: Constants.HabitTitleTextView.textTopIndent,
                                                             left: Constants.HabitTitleTextView.textLeadingIndent,
                                                             bottom: Constants.HabitTitleTextView.textBottomIndent,
                                                             right: Constants.HabitTitleTextView.textTrailingIndent)
        
        habitTitleTextView.setHeight(Constants.HabitTitleTextView.height)
        habitTitleTextView.pinTop(to: habitTitleLabel.bottomAnchor, Constants.HabitTitleTextView.topIndent)
        habitTitleTextView.pinBottom(to: wrap.bottomAnchor)
        habitTitleTextView.pinLeft(to: wrap.leadingAnchor)
        habitTitleTextView.pinRight(to: wrap.trailingAnchor)
    }
}

