//
//  HabitRegularityCell.swift
//  Doordie
//
//  Created by Arseniy on 18.01.2025.
//

import UIKit

final class HabitRegularityCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitRegularityLabel {
            static let text: String = "How often would you like to do it?"
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
        
        enum CurrentRegularityLabel {
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let leadingIndent: CGFloat = 8
        }
        
        enum ChooseRegularityButton {
            static let bgColor: UIColor = UIColor(hex: "242765")
            static let height: CGFloat = 34
            static let width: CGFloat = 34
            static let cornerRadius: CGFloat = 12
            static let trailingIndent: CGFloat = 8
            static let imageName: String = "chevron.up.chevron.down"
            static let tintColor: UIColor = .white.withAlphaComponent(0.7)
        }
        
        enum RegularityMenu {
            static let options: [String] = ["Every day", "Every week", "Every month"]
        }
    }
    
    static let reuseId: String = "HabitRegularityCell"
    
    // MARK: - UI Components
    private let habitRegularityLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let coloredWrap: UIView = UIView()
    private let currentRegularityLabel: UILabel = UILabel()
    private let chooseRegularityButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    var onRegularityChanged: ((String) -> Void)?
    
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
    func configure(with regularity: String) {
        currentRegularityLabel.text = regularity
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureWrap()
        configureHabitRegularityLabel()
        configureColoredWrap()
        configureCurrentRegularityLabel()
        configureChooseRegularityButton()
        configureChooseRegularityMenu()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitRegularityLabel() {
        wrap.addSubview(habitRegularityLabel)
        
        habitRegularityLabel.text = Constants.HabitRegularityLabel.text
        habitRegularityLabel.textColor = Constants.HabitRegularityLabel.textColor
        habitRegularityLabel.textAlignment = Constants.HabitRegularityLabel.textAlignment
        
        habitRegularityLabel.pinTop(to: wrap.topAnchor)
        habitRegularityLabel.pinLeft(to: wrap.leadingAnchor)
        habitRegularityLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureColoredWrap() {
        wrap.addSubview(coloredWrap)
        
        coloredWrap.backgroundColor = Constants.ColoredWrap.bgColor
        coloredWrap.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        
        coloredWrap.setHeight(Constants.ColoredWrap.height)
        coloredWrap.pinTop(to: habitRegularityLabel.bottomAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinBottom(to: wrap.bottomAnchor)
        coloredWrap.pinLeft(to: wrap.leadingAnchor)
        coloredWrap.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureCurrentRegularityLabel() {
        coloredWrap.addSubview(currentRegularityLabel)
        
        currentRegularityLabel.textAlignment = Constants.CurrentRegularityLabel.textAlignment
        currentRegularityLabel.textColor = Constants.CurrentRegularityLabel.textColor
        
        currentRegularityLabel.pinCenterY(to: coloredWrap.centerYAnchor)
        currentRegularityLabel.pinLeft(to: coloredWrap.leadingAnchor, Constants.CurrentRegularityLabel.leadingIndent)
    }
    
    private func configureChooseRegularityButton() {
        coloredWrap.addSubview(chooseRegularityButton)
        
        chooseRegularityButton.backgroundColor = Constants.ChooseRegularityButton.bgColor
        chooseRegularityButton.layer.cornerRadius = Constants.ChooseRegularityButton.cornerRadius
        chooseRegularityButton.setImage(UIImage(systemName: Constants.ChooseRegularityButton.imageName), for: .normal)
        chooseRegularityButton.tintColor = Constants.ChooseRegularityButton.tintColor
        
        chooseRegularityButton.setHeight(Constants.ChooseRegularityButton.height)
        chooseRegularityButton.setWidth(Constants.ChooseRegularityButton.width)
        chooseRegularityButton.pinCenterY(to: coloredWrap.centerYAnchor)
        chooseRegularityButton.pinRight(to: coloredWrap.trailingAnchor, Constants.ChooseRegularityButton.trailingIndent)
    }
    
    private func configureChooseRegularityMenu() {
        var menuActions: [UIAction] = []
        
        for measurement in Constants.RegularityMenu.options {
            let title = measurement
            let action = UIAction(title: title, image: nil) { [weak self] _ in
                self?.currentRegularityLabel.text = title
                self?.onRegularityChanged?(title)
            }
            menuActions.append(action)
        }
        
        let menu = UIMenu(title: "", children: menuActions)
        
        chooseRegularityButton.menu = menu
        chooseRegularityButton.showsMenuAsPrimaryAction = true
    }
}

