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
            static let title: String = "Create"
            static let bgColor: UIColor = UIColor(hex: "242765")
            static let cornerRadius: CGFloat = 14
            static let height: CGFloat = 50
            static let tintColor: UIColor = .white
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
    
    // MARK: - Private Methods
    private func configureUI() {
        configureCreateHabitButton()
    }
    
    private func configureCreateHabitButton() {
        contentView.addSubview(createHabitButton)
        
        createHabitButton.layer.cornerRadius = Constants.CreateHabitButton.cornerRadius
        createHabitButton.setTitle(Constants.CreateHabitButton.title, for: .normal)
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

