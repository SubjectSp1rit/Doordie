//
//  HabitConfirmHabitCreationCell.swift
//  Doordie
//
//  Created by Arseniy on 18.01.2025.
//

import UIKit

final class HabitConfirmCreationCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum CreateHabitButton {
            static let createTitle: String = "Create"
            static let saveTitle: String = "Save"
            static let bgColor: UIColor = UIColor(hex: "242765")
            static let cornerRadius: CGFloat = 14
            static let height: CGFloat = 50
            static let tintColor: UIColor = .white
            static let minTransparentAlpha: CGFloat = 0.5
            static let maxTransparentAlpha: CGFloat = 1
        }
    }
    
    static let reuseId: String = "HabitConfirmCreationCell"
    
    // MARK: - Properties
    var onCreateHabitButtonPressed: (() -> Void)?
    
    // MARK: - UI Components
    private let createHabitButton: UIButton = UIButton(type: .system)
    
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
    func configure(isNew: Bool) {
        if isNew {
            createHabitButton.setTitle(Constants.CreateHabitButton.createTitle, for: .normal)
        } else {
            createHabitButton.setTitle(Constants.CreateHabitButton.saveTitle, for: .normal)
        }
    }
    
    func configureButton(isEnabled: Bool) {
        // Меняем состояние кнопки только в том случае, если кнопка находится в противоположном состоянии
        switch (isEnabled, createHabitButton.isEnabled) {
        case (true, false):
            createHabitButton.isEnabled = true
            createHabitButton.alpha = Constants.CreateHabitButton.maxTransparentAlpha
        case (false, true):
            createHabitButton.isEnabled = false
            createHabitButton.alpha = Constants.CreateHabitButton.minTransparentAlpha
        default:
            return
        }
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureCreateHabitButton()
    }
    
    private func configureCreateHabitButton() {
        contentView.addSubview(createHabitButton)
        
        createHabitButton.layer.cornerRadius = Constants.CreateHabitButton.cornerRadius
        createHabitButton.tintColor = Constants.CreateHabitButton.tintColor
        createHabitButton.backgroundColor = Constants.CreateHabitButton.bgColor
        
        createHabitButton.addTarget(self, action: #selector(createHabitButtonPressed), for: .touchUpInside)
        
        createHabitButton.setHeight(Constants.CreateHabitButton.height)
        createHabitButton.pinTop(to: contentView.topAnchor)
        createHabitButton.pinBottom(to: contentView.bottomAnchor)
        createHabitButton.pinLeft(to: contentView.leadingAnchor)
        createHabitButton.pinRight(to: contentView.trailingAnchor)
    }
    
    // MARK: - Actions
    @objc
    private func createHabitButtonPressed() {
        onCreateHabitButtonPressed?()
    }
}

