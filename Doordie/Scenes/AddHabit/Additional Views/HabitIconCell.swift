//
//  HabitIconCell.swift
//  Doordie
//
//  Created by Arseniy on 10.01.2025.
//

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
        
        enum IconPickerMenu {
            static let menuTitle: String = "Choose an icon"
            static let lightThemeIconsColor: UIColor = .black
            static let darkThemeIconsColor: UIColor = .white
        }
        
        enum MenuOther {
            static let title: String = "Other"
            static let icons: [String] = ["heart", "trophy.fill", "medal.fill", "gauge.with.needle.fill", "pill.fill", "cross.fill", "face.smiling", "eyes", "sparkles", "atom", "message.fill", "phone.fill", "exclamationmark.triangle.fill", "lightbulb.fill", "cart.fill"]
        }
        
        enum MenuSports {
            static let title: String = "Sports"
            static let icons: [String] = ["figure.walk", "figure.run", "figure.run.treadmill", "figure.basketball", "figure.boxing", "figure.cooldown", "figure.core.training", "figure.outdoor.cycle", "figure.mind.and.body", "figure.pilates", "figure.indoor.rowing", "figure.strengthtraining.traditional", "figure.yoga", "dumbbell.fill", "basketball.fill", "baseball.fill", "tennis.racket", "volleyball.fill", ""]
        }
        
        enum MenuFood {
            static let title: String = "Food"
            static let icons: [String] = ["waterbottle.fill", "fish.fill", "carrot.fill"]
        }
        
        enum MenuTransport {
            static let title: String = "Transport"
            static let icons: [String] = ["airplane", "car.fill", "bolt.car.fill", "scooter", "motorcycle.fill", "fuelpump.fill", "ev.charger.fill"]
        }
        
        enum MenuNature {
            static let title: String = "Nature"
            static let icons: [String] = ["sun.max.fill", "moon.fill", "cloud.fill", "cloud.drizzle.fill", "snowflake", "drop.fill", "bolt.fill", "cat.fill", "dog.fill", "tortoise.fill", "bird.fill", "pawprint.fill", "leaf.fill", "tree.fill"]
        }
        
        enum MenuEntertainment {
            static let title: String = "Entertainment"
            static let icons: [String] = ["gamecontroller.fill", "playstation.logo", "xmark.triangle.circle.square", "xbox.logo", "formfitting.gamecontroller.fill", "headset"]
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
        func createIconSubmenu(with title: String, iconNames: [String]) -> UIMenu {
            var menuActions: [UIAction] = []
            
            for iconName in iconNames {
                let image: UIImage?
                let userTheme = traitCollection.userInterfaceStyle
                image = UIImage(systemName: iconName)?.getWithTint(for: userTheme)
                let action = UIAction(title: "", image: image) { [weak self] _ in
                    self?.selectedIcon.image = image
                }
                menuActions.append(action)
            }
            
            let menu: UIMenu = UIMenu(title: title, options: .displayAsPalette, children: menuActions)
            
            return menu
        }
        
        let menuOther = createIconSubmenu(with: Constants.MenuOther.title, iconNames: Constants.MenuOther.icons)
        let menuSports = createIconSubmenu(with: Constants.MenuSports.title, iconNames: Constants.MenuSports.icons)
        let menuFood = createIconSubmenu(with: Constants.MenuFood.title, iconNames: Constants.MenuFood.icons)
        let menuTransport = createIconSubmenu(with: Constants.MenuTransport.title, iconNames: Constants.MenuTransport.icons)
        let menuNature = createIconSubmenu(with: Constants.MenuNature.title, iconNames: Constants.MenuNature.icons)
        let menuEntertainment = createIconSubmenu(with: Constants.MenuEntertainment.title, iconNames: Constants.MenuEntertainment.icons)
        
        let submenusArray: [UIMenu] = [menuOther, menuSports, menuFood, menuTransport, menuNature, menuEntertainment]
        let menu = UIMenu(title: Constants.IconPickerMenu.menuTitle, children: submenusArray)
        
        showIconsButton.menu = menu
        showIconsButton.showsMenuAsPrimaryAction = true
    }
}

