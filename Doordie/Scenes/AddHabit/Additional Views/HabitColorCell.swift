//
//  HabitColorCell.swift
//  Doordie
//
//  Created by Arseniy on 10.01.2025.
//

import Foundation
import UIKit

final class HabitColorCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitColorLabel {
            static let text: String = "Color"
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
        
        enum ColoredCircle {
            static let bgColor: UIColor = UIColor(hex: "6475CC")
            static let height: CGFloat = 34
            static let width: CGFloat = 34
            static let cornerRadius: CGFloat = 17
            static let leadingIndent: CGFloat = 8
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
        
        enum ColorPicker {
            static let menuImageName: String = "circle.fill"
            static let menuTitle: String = "Choose a background icon color"
            static let colorHexCodes: [String] = ["FF0000", "F28500", "FFF200", "006400", "90EE90", "ADD8E6", "524F81", "6475CC", "6F2DA8", "FC8EAC", "41424C"]
            static let colorNames: [String] = ["Tomato", "Tangerine", "Banana", "Basil", "Sage", "Peacock", "Blueberry", "Lavender", "Grape", "Flamingo", "Graphite"]
        }
    }
    
    static let reuseId: String = "HabitColorCell"
    
    // MARK: - UI Components
    private let habitColorLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let coloredWrap: UIView = UIView()
    private let coloredCircle: UIView = UIView()
    private let showColorsButton: UIButton = UIButton(type: .system)
    private let colorPickerMenu: UIMenu = UIMenu()
    
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
        configureHabitColorLabel()
        configureColoredWrap()
        configureColoredCircle()
        configureShowColorButton()
        configureColorPickerMenu()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitColorLabel() {
        wrap.addSubview(habitColorLabel)
        
        habitColorLabel.text = Constants.HabitColorLabel.text
        habitColorLabel.textColor = Constants.HabitColorLabel.textColor
        habitColorLabel.textAlignment = Constants.HabitColorLabel.textAlignment
        
        habitColorLabel.pinTop(to: wrap.topAnchor)
        habitColorLabel.pinLeft(to: wrap.leadingAnchor)
        habitColorLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureColoredWrap() {
        wrap.addSubview(coloredWrap)
        
        coloredWrap.backgroundColor = Constants.ColoredWrap.bgColor
        coloredWrap.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        
        coloredWrap.setHeight(Constants.ColoredWrap.height)
        coloredWrap.pinTop(to: habitColorLabel.bottomAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinBottom(to: wrap.bottomAnchor)
        coloredWrap.pinLeft(to: wrap.leadingAnchor)
        coloredWrap.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureColoredCircle() {
        coloredWrap.addSubview(coloredCircle)
        
        coloredCircle.backgroundColor = Constants.ColoredCircle.bgColor
        coloredCircle.layer.cornerRadius = Constants.ColoredCircle.cornerRadius
        
        coloredCircle.setHeight(Constants.ColoredCircle.height)
        coloredCircle.setWidth(Constants.ColoredCircle.width)
        coloredCircle.pinCenterY(to: coloredWrap.centerYAnchor)
        coloredCircle.pinLeft(to: coloredWrap.leadingAnchor, Constants.ColoredCircle.leadingIndent)
    }
    
    private func configureShowColorButton() {
        coloredWrap.addSubview(showColorsButton)
        
        showColorsButton.backgroundColor = Constants.ShowColorsButton.bgColor
        showColorsButton.layer.cornerRadius = Constants.ShowColorsButton.cornerRadius
        showColorsButton.setImage(UIImage(systemName: Constants.ShowColorsButton.imageName), for: .normal)
        showColorsButton.tintColor = Constants.ShowColorsButton.tintColor
        
        showColorsButton.setHeight(Constants.ShowColorsButton.height)
        showColorsButton.setWidth(Constants.ShowColorsButton.width)
        showColorsButton.pinCenterY(to: coloredWrap.centerYAnchor)
        showColorsButton.pinRight(to: coloredWrap.trailingAnchor, Constants.ShowColorsButton.trailingIndent)
    }
    
    private func configureColorPickerMenu() {
        var menuActions: [UIAction] = []
        
        for (index, color) in Constants.ColorPicker.colorHexCodes.enumerated() {
            let image = UIImage(systemName: Constants.ColorPicker.menuImageName)?.withTintColor(UIColor(hex: color), renderingMode: .alwaysOriginal)
            let title = Constants.ColorPicker.colorNames[index]
            let action = UIAction(title: title, image: image) { [weak self] _ in
                self?.coloredCircle.backgroundColor = UIColor(hex: color)
            }
            menuActions.append(action)
        }
        
        let menu = UIMenu(title: Constants.ColorPicker.menuTitle, children: menuActions)
        
        showColorsButton.menu = menu
        showColorsButton.showsMenuAsPrimaryAction = true
    }
}
