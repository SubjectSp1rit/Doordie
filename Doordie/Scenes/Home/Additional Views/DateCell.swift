//
//  DateCell.swift
//  Doordie
//
//  Created by Arseniy on 29.12.2024.
//

import Foundation
import UIKit

final class DateCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let contentViewBgColor: UIColor = .clear
        static let cellBgColor: UIColor = .clear
        static let contentViewHeight: CGFloat = 100
        
        // wrap
        static let unselectedWrapBgColorHexCode: String = "6A729F"
        static let unselectedWrapBgColor: UIColor = UIColor(hex: unselectedWrapBgColorHexCode).withAlphaComponent(0.5)
        static let selectedWrapBgColorHexCode: String = "3A50C2"
        static let selectedWrapBgColor: UIColor = UIColor(hex: selectedWrapBgColorHexCode)
        static let wrapCornerRadius: CGFloat = 20
        static let wrapHeight: CGFloat = 100
        static let wrapWidth: CGFloat = 80
        static let wrapShadowColor: CGColor = UIColor.black.cgColor
        static let wrapShadowOpacity: Float = 0.5
        static let wrapXOffset: CGFloat = 0
        static let wrapYOffset: CGFloat = 4
        static let wrapShadowRadius: CGFloat = 8
        
        enum Stack {
            static let axis: NSLayoutConstraint.Axis = .vertical
            static let spacing: CGFloat = 0
            static let distribution: UIStackView.Distribution = .fill
            static let alignment: UIStackView.Alignment = .center
        }
        
        enum NumberLabel {
            static let fontSize: CGFloat = 30
            static let fontWeight: UIFont.Weight = .light
            static let textAlignment: NSTextAlignment = .center
            static let textColor: UIColor = .white.withAlphaComponent(0.9)
        }
        
        // dayOfWeekLabel
        static let dayOfWeekLabelFontSize: CGFloat = 20
        static let dayOfWeekLabelFontWeight: UIFont.Weight = .light
        static let dayOfWeekLabelTextAlignment: NSTextAlignment = .center
        static let dayOfWeekLabelTextColor: UIColor = .lightGray.withAlphaComponent(0.8)
    }
    
    static let reuseId: String = "DateCell"
    
    // MARK: - UI Components
    private let stack: UIStackView = UIStackView()
    private let wrap: UIView = UIView()
    private let numberLabel: UILabel = UILabel()
    private let dayOfWeekLabel: UILabel = UILabel()
    
    // MARK: - Variables
    var onProfileImageTapped: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure() {
        numberLabel.text = "31"
        dayOfWeekLabel.text = "Tue"
    }
    
    func didSelect() {
        wrap.backgroundColor = Constants.selectedWrapBgColor
    }
    
    func unselect() {
        wrap.backgroundColor = Constants.unselectedWrapBgColor
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.cellBgColor
        contentView.backgroundColor = Constants.contentViewBgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureStack()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.unselectedWrapBgColor
        wrap.layer.cornerRadius = Constants.wrapCornerRadius
        wrap.setWidth(Constants.wrapWidth)
        wrap.setHeight(Constants.wrapHeight)
        
        // Тень
        wrap.layer.shadowColor = Constants.wrapShadowColor
        wrap.layer.shadowOpacity = Constants.wrapShadowOpacity
        wrap.layer.shadowOffset = CGSize(width: Constants.wrapXOffset, height: Constants.wrapYOffset)
        wrap.layer.shadowRadius = Constants.wrapShadowRadius
        wrap.layer.masksToBounds = false
        
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinTop(to: contentView.topAnchor)
    }
    
    private func configureStack() {
        wrap.addSubview(stack)
        
        configureNumberLabel()
        configureDayOfWeekLabel()
        
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(dayOfWeekLabel)
        
        stack.axis = Constants.Stack.axis
        stack.spacing = Constants.Stack.spacing
        stack.distribution = Constants.Stack.distribution
        stack.alignment = Constants.Stack.alignment
        
        stack.pinCenterX(to: wrap)
        stack.pinCenterY(to: wrap)
    }
    
    private func configureNumberLabel() {
        numberLabel.font = UIFont.systemFont(ofSize: Constants.numberLabelFontSize, weight: Constants.numberLabelFontWeight)
        numberLabel.textAlignment = Constants.numberLabelTextAlignment
        numberLabel.textColor = Constants.numberLabelTextColor
    }
    
    private func configureDayOfWeekLabel() {
        dayOfWeekLabel.font = UIFont.systemFont(ofSize: Constants.dayOfWeekLabelFontSize, weight: Constants.dayOfWeekLabelFontWeight)
        dayOfWeekLabel.textAlignment = Constants.dayOfWeekLabelTextAlignment
        dayOfWeekLabel.textColor = Constants.dayOfWeekLabelTextColor
    }
    
    // MARK: - Factories
}
