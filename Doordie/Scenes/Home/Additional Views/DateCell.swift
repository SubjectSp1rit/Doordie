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
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
            static let height: CGFloat = 100
        }
        
        enum Wrap {
            static let unselectedBgColor: UIColor = UIColor(hex: "6A729F").withAlphaComponent(0.5)
            static let selectedBgColor: UIColor = UIColor(hex: "3A50C2")
            static let cornerRadius: CGFloat = 20
            static let height: CGFloat = 100
            static let width: CGFloat = 80
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
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
        
        enum DayOfWeekLabel {
            static let fontSize: CGFloat = 20
            static let fontWeight: UIFont.Weight = .light
            static let textAlignment: NSTextAlignment = .center
            static let textColor: UIColor = .lightGray.withAlphaComponent(0.8)
        }
    }
    
    static let reuseId: String = "DateCell"
    
    // MARK: - UI Components
    private let stack: UIStackView = UIStackView()
    private let numberLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
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
        wrap.backgroundColor = Constants.Wrap.selectedBgColor
    }
    
    func unselect() {
        wrap.backgroundColor = Constants.Wrap.unselectedBgColor
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
        
        wrap.backgroundColor = Constants.Wrap.unselectedBgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrap.setWidth(Constants.Wrap.width)
        wrap.setHeight(Constants.Wrap.height)
        
        // Тень
        wrap.layer.shadowColor = Constants.Wrap.shadowColor
        wrap.layer.shadowOpacity = Constants.Wrap.shadowOpacity
        wrap.layer.shadowOffset = CGSize(width: Constants.Wrap.shadowOffsetX, height: Constants.Wrap.shadowOffsetY)
        wrap.layer.shadowRadius = Constants.Wrap.shadowRadius
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
        numberLabel.font = UIFont.systemFont(ofSize: Constants.NumberLabel.fontSize, weight: Constants.NumberLabel.fontWeight)
        numberLabel.textAlignment = Constants.NumberLabel.textAlignment
        numberLabel.textColor = Constants.NumberLabel.textColor
    }
    
    private func configureDayOfWeekLabel() {
        dayOfWeekLabel.font = UIFont.systemFont(ofSize: Constants.DayOfWeekLabel.fontSize, weight: Constants.DayOfWeekLabel.fontWeight)
        dayOfWeekLabel.textAlignment = Constants.DayOfWeekLabel.textAlignment
        dayOfWeekLabel.textColor = Constants.DayOfWeekLabel.textColor
    }
}
