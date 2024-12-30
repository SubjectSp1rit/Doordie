//
//  DayPartCell.swift
//  Doordie
//
//  Created by Arseniy on 31.12.2024.
//

import Foundation
import UIKit

final class DayPartCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let bgColor: UIColor = .clear
            static let height: CGFloat = 40
            static let width: CGFloat = 100
        }
        
        enum Stack {
            static let axis: NSLayoutConstraint.Axis = .vertical
            static let spacing: CGFloat = 3
            static let distribution: UIStackView.Distribution = .fill
            static let alignment: UIStackView.Alignment = .center
        }
        
        enum DayPartLabel {
            static let fontSize: CGFloat = 20
            static let fontWeight: UIFont.Weight = .medium
            static let textAlignment: NSTextAlignment = .center
            static let selectedTextColor: UIColor = .white
            static let unselectedTextColor: UIColor = .white.withAlphaComponent(0.3)
        }
        
        enum UnderlineView {
            static let height: CGFloat = 3
            static let width: CGFloat = 100
            static let selectedBgColor: UIColor = .white
            static let unselectedBgColor: UIColor = .white.withAlphaComponent(0.3)
        }
    }
    
    static let reuseId: String = "DayPartCell"
    
    // MARK: - UI Components
    private let stack: UIStackView = UIStackView()
    private let dayPartLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let underlineView: UIView = UIView()
    
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
    func configure(with dayPart: String) {
        dayPartLabel.text = dayPart
    }
    
    func didSelect() {
        underlineView.backgroundColor = Constants.UnderlineView.selectedBgColor
        dayPartLabel.textColor = Constants.DayPartLabel.selectedTextColor
    }
    
    func unselect() {
        underlineView.backgroundColor = Constants.UnderlineView.unselectedBgColor
        dayPartLabel.textColor = Constants.DayPartLabel.unselectedTextColor
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureStack()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.setWidth(Constants.Wrap.width)
        wrap.setHeight(Constants.Wrap.height)
        
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinTop(to: contentView.topAnchor)
    }
    
    private func configureStack() {
        wrap.addSubview(stack)
        
        configureDayPartLabel()
        configureUnderlineView()
        
        stack.addArrangedSubview(dayPartLabel)
        stack.addArrangedSubview(underlineView)
        
        stack.axis = Constants.Stack.axis
        stack.spacing = Constants.Stack.spacing
        stack.distribution = Constants.Stack.distribution
        stack.alignment = Constants.Stack.alignment
        
        stack.pinCenterX(to: wrap)
        stack.pinCenterY(to: wrap)
    }
    
    private func configureDayPartLabel() {
        dayPartLabel.textColor = Constants.DayPartLabel.unselectedTextColor
        dayPartLabel.font = UIFont.systemFont(ofSize: Constants.DayPartLabel.fontSize, weight: Constants.DayPartLabel.fontWeight)
        dayPartLabel.textAlignment = Constants.DayPartLabel.textAlignment
    }
    
    private func configureUnderlineView() {
        underlineView.backgroundColor = Constants.UnderlineView.unselectedBgColor
        underlineView.setHeight(Constants.UnderlineView.height)
        underlineView.setWidth(Constants.UnderlineView.width)
    }
}

