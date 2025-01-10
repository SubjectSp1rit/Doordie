//
//  HabitIconCell.swift
//  Doordie
//
//  Created by Arseniy on 10.01.2025.
//

import Foundation
import UIKit

final class HabitIconCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitColorLabel {
            static let text: String = "Icon"
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
        
        enum SelectedIcon {
            static let standardImageName: String = "heart"
            static let contentMode: UIImageView.ContentMode = .scaleAspectFill
            static let tintColor: UIColor = .white
            static let height: CGFloat = 34
            static let leadingIndent: CGFloat = 12
        }
        
        enum ShowColorsButton {
            static let bgColor: UIColor = UIColor(hex: "242765")
            static let height: CGFloat = 34
            static let width: CGFloat = 34
            static let cornerRadius: CGFloat = 12
            static let trailingIndent: CGFloat = 8
            static let imageName: String = "chevron.up.chevron.down"
            static let tintColor: UIColor = .white.withAlphaComponent(0.7)
        }
        
        enum IconPicker {
            static let menuTitle: String = "Choose an icon"
            static let icons: [String] = ["heart", "figure.walk", "figure.run", "figure.run.treadmill"]
            static let iconNames: [String] = ["Heart", "Walk", "Run", "Treadmill"]
        }
    }
    
    static let reuseId: String = "HabitIconCell"
    
    // MARK: - UI Components
    private let habitIconLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let coloredWrap: UIView = UIView()
    private let selectedIcon: UIImageView = UIImageView()
    private let showIconsButton: UIButton = UIButton(type: .system)
    private let iconPickerMenu: UIMenu = UIMenu()
    
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
        configureHabitIconLabel()
        configureColoredWrap()
        configureSelectedIcon()
        configureShowIconsButton()
        configureIconPickerMenu()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitIconLabel() {
        wrap.addSubview(habitIconLabel)
        
        habitIconLabel.text = Constants.HabitColorLabel.text
        habitIconLabel.textColor = Constants.HabitColorLabel.textColor
        habitIconLabel.textAlignment = Constants.HabitColorLabel.textAlignment
        
        habitIconLabel.pinTop(to: wrap.topAnchor)
        habitIconLabel.pinLeft(to: wrap.leadingAnchor)
        habitIconLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureColoredWrap() {
        wrap.addSubview(coloredWrap)
        
        coloredWrap.backgroundColor = Constants.ColoredWrap.bgColor
        coloredWrap.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        
        coloredWrap.setHeight(Constants.ColoredWrap.height)
        coloredWrap.pinTop(to: habitIconLabel.bottomAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinBottom(to: wrap.bottomAnchor)
        coloredWrap.pinLeft(to: wrap.leadingAnchor)
        coloredWrap.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureSelectedIcon() {
        coloredWrap.addSubview(selectedIcon)
        
        selectedIcon.image = UIImage(systemName: Constants.SelectedIcon.standardImageName)
        selectedIcon.tintColor = Constants.SelectedIcon.tintColor
        selectedIcon.contentMode = Constants.SelectedIcon.contentMode
        
        selectedIcon.setHeight(Constants.SelectedIcon.height)
        selectedIcon.pinCenterY(to: coloredWrap.centerYAnchor)
        selectedIcon.pinLeft(to: coloredWrap.leadingAnchor, Constants.SelectedIcon.leadingIndent)
    }
    
    private func configureShowIconsButton() {
        coloredWrap.addSubview(showIconsButton)
        
        showIconsButton.backgroundColor = Constants.ShowColorsButton.bgColor
        showIconsButton.layer.cornerRadius = Constants.ShowColorsButton.cornerRadius
        showIconsButton.setImage(UIImage(systemName: Constants.ShowColorsButton.imageName), for: .normal)
        showIconsButton.tintColor = Constants.ShowColorsButton.tintColor
        
        showIconsButton.setHeight(Constants.ShowColorsButton.height)
        showIconsButton.setWidth(Constants.ShowColorsButton.width)
        showIconsButton.pinCenterY(to: coloredWrap.centerYAnchor)
        showIconsButton.pinRight(to: coloredWrap.trailingAnchor, Constants.ShowColorsButton.trailingIndent)
    }
    
    private func configureIconPickerMenu() {
        var menuOtherActions: [UIAction] = []
        
        for (index, icon) in Constants.IconPicker.icons.enumerated() {
            let image = UIImage(systemName: icon)?.withTintColor(Constants.SelectedIcon.tintColor, renderingMode: .alwaysOriginal)
            let title = Constants.IconPicker.iconNames[index]
            let action = UIAction(title: title, image: image) { [weak self] _ in
                self?.selectedIcon.image = image
            }
            menuOtherActions.append(action)
        }
        let menuOther: UIMenu = UIMenu(title: "Other", options: .displayAsPalette, children: menuOtherActions)
        
        
        var menuSportsActions: [UIAction] = []
        for (index, icon) in Constants.IconPicker.icons.enumerated() {
            let image = UIImage(systemName: icon)?.withTintColor(Constants.SelectedIcon.tintColor, renderingMode: .alwaysOriginal)
            let title = Constants.IconPicker.iconNames[index]
            let action = UIAction(title: title, image: image) { [weak self] _ in
                self?.selectedIcon.image = image
            }
            menuSportsActions.append(action)
        }
        let menuSports: UIMenu = UIMenu(title: "Sports", options: .displayAsPalette, children: menuOtherActions)
        
        let menu = UIMenu(title: Constants.IconPicker.menuTitle, children: [menuOther, menuSports])
        
        showIconsButton.menu = menu
        showIconsButton.showsMenuAsPrimaryAction = true
    }
}

