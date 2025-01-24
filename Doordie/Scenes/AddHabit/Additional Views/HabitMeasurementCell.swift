//
//  HabitMeasurementCell.swift
//  Doordie
//
//  Created by Arseniy on 12.01.2025.
//

import UIKit

final class HabitMeasurementCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum HabitMeasurementLabel {
            static let text: String = "Measurement"
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
        
        enum MeasurementValueLabel {
            static let text: String = "Mins"
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let leadingIndent: CGFloat = 8
        }
        
        enum ChooseMeasurementButton {
            static let bgColor: UIColor = UIColor(hex: "242765")
            static let height: CGFloat = 34
            static let width: CGFloat = 34
            static let cornerRadius: CGFloat = 12
            static let trailingIndent: CGFloat = 8
            static let imageName: String = "chevron.up.chevron.down"
            static let tintColor: UIColor = .white.withAlphaComponent(0.7)
        }
        
        enum ChooseMeasurementMenu {
            static let menuTitle: String = "Choose a measurement"
            static let measurements: [String] = ["Mins", "Times", "Mls"]
        }
    }
    
    static let reuseId: String = "HabitMeasurementCell"
    
    // MARK: - UI Components
    private let habitMeasurementLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    private let coloredWrap: UIView = UIView()
    private let measurementValueLabel: UILabel = UILabel()
    private let chooseMeasurementButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    var onMeasurementChanged: ((String) -> Void)?
    
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
    func configureQuantityValueLabel(with value: String) {
        measurementValueLabel.text = value
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureWrap()
        configureHabitMeasurementLabel()
        configureColoredWrap()
        configureMeasurementValueLabel()
        configureChooseMeasurementButton()
        configureChooseMeasurementMenu()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
    }
    
    private func configureHabitMeasurementLabel() {
        wrap.addSubview(habitMeasurementLabel)
        
        habitMeasurementLabel.text = Constants.HabitMeasurementLabel.text
        habitMeasurementLabel.textColor = Constants.HabitMeasurementLabel.textColor
        habitMeasurementLabel.textAlignment = Constants.HabitMeasurementLabel.textAlignment
        
        habitMeasurementLabel.pinTop(to: wrap.topAnchor)
        habitMeasurementLabel.pinLeft(to: wrap.leadingAnchor)
        habitMeasurementLabel.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureColoredWrap() {
        wrap.addSubview(coloredWrap)
        
        coloredWrap.backgroundColor = Constants.ColoredWrap.bgColor
        coloredWrap.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        
        coloredWrap.setHeight(Constants.ColoredWrap.height)
        coloredWrap.pinTop(to: habitMeasurementLabel.bottomAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinBottom(to: wrap.bottomAnchor)
        coloredWrap.pinLeft(to: wrap.leadingAnchor)
        coloredWrap.pinRight(to: wrap.trailingAnchor)
    }
    
    private func configureMeasurementValueLabel() {
        coloredWrap.addSubview(measurementValueLabel)
        
        measurementValueLabel.text = Constants.MeasurementValueLabel.text
        measurementValueLabel.textAlignment = Constants.MeasurementValueLabel.textAlignment
        measurementValueLabel.textColor = Constants.MeasurementValueLabel.textColor
        
        measurementValueLabel.pinCenterY(to: coloredWrap.centerYAnchor)
        measurementValueLabel.pinLeft(to: coloredWrap.leadingAnchor, Constants.MeasurementValueLabel.leadingIndent)
    }
    
    private func configureChooseMeasurementButton() {
        coloredWrap.addSubview(chooseMeasurementButton)
        
        chooseMeasurementButton.backgroundColor = Constants.ChooseMeasurementButton.bgColor
        chooseMeasurementButton.layer.cornerRadius = Constants.ChooseMeasurementButton.cornerRadius
        chooseMeasurementButton.setImage(UIImage(systemName: Constants.ChooseMeasurementButton.imageName), for: .normal)
        chooseMeasurementButton.tintColor = Constants.ChooseMeasurementButton.tintColor
        
        chooseMeasurementButton.setHeight(Constants.ChooseMeasurementButton.height)
        chooseMeasurementButton.setWidth(Constants.ChooseMeasurementButton.width)
        chooseMeasurementButton.pinCenterY(to: coloredWrap.centerYAnchor)
        chooseMeasurementButton.pinRight(to: coloredWrap.trailingAnchor, Constants.ChooseMeasurementButton.trailingIndent)
    }
    
    private func configureChooseMeasurementMenu() {
        var menuColors: [UIAction] = []
        
        for measurement in Constants.ChooseMeasurementMenu.measurements {
            let title = measurement
            let action = UIAction(title: title, image: nil) { [weak self] _ in
                self?.measurementValueLabel.text = title
                self?.onMeasurementChanged?(title)
            }
            menuColors.append(action)
        }
        
        let menu = UIMenu(title: Constants.ChooseMeasurementMenu.menuTitle, children: menuColors)
        
        chooseMeasurementButton.menu = menu
        chooseMeasurementButton.showsMenuAsPrimaryAction = true
    }
}


