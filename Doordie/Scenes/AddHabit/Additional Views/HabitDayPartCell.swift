//
//  HabitDayPartCell.swift
//  Doordie
//
//  Created by Arseniy on 18.01.2025.
//

import UIKit

final class HabitDayPartCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitDayPartLabel {
            static let text: String = "Choose your habit time"
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
        
        enum CurrentDayPartLabel {
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let leadingIndent: CGFloat = 8
        }
        
        enum ChooseDayPartButton {
            static let bgColor: UIColor = UIColor(hex: "242765")
            static let height: CGFloat = 34
            static let width: CGFloat = 34
            static let cornerRadius: CGFloat = 12
            static let trailingIndent: CGFloat = 8
            static let imageName: String = "chevron.up.chevron.down"
            static let tintColor: UIColor = .white.withAlphaComponent(0.7)
        }
        
        enum DayPartMenu {
            static let options: [String] = ["Any time", "Morning", "Day", "Evening", "Night"]
        }
    }
    
    static let reuseId: String = "HabitDayPartCell"
    
    // MARK: - UI Components
    private let habitDayPartLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let coloredWrap: UIView = UIView()
    private let currentDayPartLabel: UILabel = UILabel()
    private let chooseDayPartButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    var onDayPartChanged: ((String) -> Void)?
    
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
        currentDayPartLabel.text = dayPart
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureWrap()
        configureHabitDayPartLabel()
        configureColoredWrap()
        configureCurrentDayPartLabel()
        configureChooseDayPartButton()
        configureChooseDayPartMenu()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitDayPartLabel() {
        wrap.addSubview(habitDayPartLabel)
        
        habitDayPartLabel.text = Constants.HabitDayPartLabel.text
        habitDayPartLabel.textColor = Constants.HabitDayPartLabel.textColor
        habitDayPartLabel.textAlignment = Constants.HabitDayPartLabel.textAlignment
        
        habitDayPartLabel.pinTop(to: wrap.topAnchor)
        habitDayPartLabel.pinLeft(to: wrap.leadingAnchor)
        habitDayPartLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureColoredWrap() {
        wrap.addSubview(coloredWrap)
        
        coloredWrap.backgroundColor = Constants.ColoredWrap.bgColor
        coloredWrap.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        
        coloredWrap.setHeight(Constants.ColoredWrap.height)
        coloredWrap.pinTop(to: habitDayPartLabel.bottomAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinBottom(to: wrap.bottomAnchor)
        coloredWrap.pinLeft(to: wrap.leadingAnchor)
        coloredWrap.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureCurrentDayPartLabel() {
        coloredWrap.addSubview(currentDayPartLabel)
        
        currentDayPartLabel.textAlignment = Constants.CurrentDayPartLabel.textAlignment
        currentDayPartLabel.textColor = Constants.CurrentDayPartLabel.textColor
        
        currentDayPartLabel.pinCenterY(to: coloredWrap.centerYAnchor)
        currentDayPartLabel.pinLeft(to: coloredWrap.leadingAnchor, Constants.CurrentDayPartLabel.leadingIndent)
    }
    
    private func configureChooseDayPartButton() {
        coloredWrap.addSubview(chooseDayPartButton)
        
        chooseDayPartButton.backgroundColor = Constants.ChooseDayPartButton.bgColor
        chooseDayPartButton.layer.cornerRadius = Constants.ChooseDayPartButton.cornerRadius
        chooseDayPartButton.setImage(UIImage(systemName: Constants.ChooseDayPartButton.imageName), for: .normal)
        chooseDayPartButton.tintColor = Constants.ChooseDayPartButton.tintColor
        
        chooseDayPartButton.setHeight(Constants.ChooseDayPartButton.height)
        chooseDayPartButton.setWidth(Constants.ChooseDayPartButton.width)
        chooseDayPartButton.pinCenterY(to: coloredWrap.centerYAnchor)
        chooseDayPartButton.pinRight(to: coloredWrap.trailingAnchor, Constants.ChooseDayPartButton.trailingIndent)
    }
    
    private func configureChooseDayPartMenu() {
        var menuActions: [UIAction] = []
        
        for measurement in Constants.DayPartMenu.options {
            let title = measurement
            let action = UIAction(title: title, image: nil) { [weak self] _ in
                self?.currentDayPartLabel.text = title
                self?.onDayPartChanged?(title)
            }
            menuActions.append(action)
        }
        
        let menu = UIMenu(title: "", children: menuActions)
        
        chooseDayPartButton.menu = menu
        chooseDayPartButton.showsMenuAsPrimaryAction = true
    }
}

