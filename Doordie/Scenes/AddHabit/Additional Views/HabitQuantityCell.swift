//
//  HabitQuantityCell.swift
//  Doordie
//
//  Created by Arseniy on 12.01.2025.
//

import UIKit

final class HabitQuantityCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitQuantityLabel {
            static let text: String = "Quantity"
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
        }
        
        enum ColoredWrap {
            static let height: CGFloat = 50
            static let topIndent: CGFloat = 5
            static let bgColor: UIColor = UIColor(hex: "5771DB").withAlphaComponent(0.7)
            static let cornerRadius: CGFloat = 14
        }
        
        enum Wrap {
            static let bgColor: UIColor = .clear
        }
        
        enum QuantityValueLabel {
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let leadingIndent: CGFloat = 8
        }
        
        enum EnterQuantityButton {
            static let bgColor: UIColor = UIColor(hex: "242765")
            static let height: CGFloat = 34
            static let width: CGFloat = 34
            static let cornerRadius: CGFloat = 12
            static let trailingIndent: CGFloat = 8
            static let imageName: String = "chevron.up.chevron.down"
            static let tintColor: UIColor = .white.withAlphaComponent(0.7)
        }
    }
    
    static let reuseId: String = "HabitQuantityCell"
    
    // MARK: - UI Components
    private let habitQuantityLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let coloredWrap: UIView = UIView()
    private let quantityValueLabel: UILabel = UILabel()
    private let enterQuantityButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    var onEnterQuantityButtonPressed: (() -> Void)?
    
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
    func configure(with value: String) {
        quantityValueLabel.text = value
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureWrap()
        configureHabitQuantityLabel()
        configureColoredWrap()
        configureQuantityValueLabel()
        configureEnterQuantityButton()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitQuantityLabel() {
        wrap.addSubview(habitQuantityLabel)
        
        habitQuantityLabel.text = Constants.HabitQuantityLabel.text
        habitQuantityLabel.textColor = Constants.HabitQuantityLabel.textColor
        habitQuantityLabel.textAlignment = Constants.HabitQuantityLabel.textAlignment
        
        habitQuantityLabel.pinTop(to: wrap.topAnchor)
        habitQuantityLabel.pinLeft(to: wrap.leadingAnchor)
        habitQuantityLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureColoredWrap() {
        wrap.addSubview(coloredWrap)
        
        coloredWrap.backgroundColor = Constants.ColoredWrap.bgColor
        coloredWrap.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        
        coloredWrap.setHeight(Constants.ColoredWrap.height)
        coloredWrap.pinTop(to: habitQuantityLabel.bottomAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinBottom(to: wrap.bottomAnchor)
        coloredWrap.pinLeft(to: wrap.leadingAnchor)
        coloredWrap.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureQuantityValueLabel() {
        coloredWrap.addSubview(quantityValueLabel)
        
        quantityValueLabel.textAlignment = Constants.QuantityValueLabel.textAlignment
        quantityValueLabel.textColor = Constants.QuantityValueLabel.textColor
        
        quantityValueLabel.pinCenterY(to: coloredWrap.centerYAnchor)
        quantityValueLabel.pinLeft(to: coloredWrap.leadingAnchor, Constants.QuantityValueLabel.leadingIndent)
    }
    
    private func configureEnterQuantityButton() {
        coloredWrap.addSubview(enterQuantityButton)
        
        enterQuantityButton.backgroundColor = Constants.EnterQuantityButton.bgColor
        enterQuantityButton.layer.cornerRadius = Constants.EnterQuantityButton.cornerRadius
        enterQuantityButton.setImage(UIImage(systemName: Constants.EnterQuantityButton.imageName), for: .normal)
        enterQuantityButton.tintColor = Constants.EnterQuantityButton.tintColor
        
        enterQuantityButton.addTarget(self, action: #selector(enterQuantityButtonPressed), for: .touchUpInside)
        
        
        enterQuantityButton.setHeight(Constants.EnterQuantityButton.height)
        enterQuantityButton.setWidth(Constants.EnterQuantityButton.width)
        enterQuantityButton.pinCenterY(to: coloredWrap.centerYAnchor)
        enterQuantityButton.pinRight(to: coloredWrap.trailingAnchor, Constants.EnterQuantityButton.trailingIndent)
    }
    
    // MARK: - Actions
    @objc
    private func enterQuantityButtonPressed() {
        onEnterQuantityButtonPressed?()
    }
}

