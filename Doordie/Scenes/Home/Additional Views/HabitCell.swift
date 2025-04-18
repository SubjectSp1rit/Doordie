//
//  HabitCell.swift
//  Doordie
//
//  Created by Arseniy on 31.12.2024.
//

import UIKit

final class HabitCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 70
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 14
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
            static let bottomIndent: CGFloat = 10
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
        enum CheckmarkButton {
            static let cornerRadius: CGFloat = 12
            static let height: CGFloat = 24
            static let width: CGFloat = 24
            static let unselectedBgColor: UIColor = UIColor(hex: "5769C9")
            static let selectedBgColor: UIColor = UIColor(hex: "478039").withAlphaComponent(0.9)
            static let imageName: String = "greenCheckmark"
            static let leadingIndent: CGFloat = 12
            static let imageHeight: CGFloat = 14
            static let imageWidth: CGFloat = 14
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
        enum HabitImageWrap {
            static let height: CGFloat = 46
            static let width: CGFloat = 46
            static let cornerRadius: CGFloat = 14
            static let bgColor: UIColor = UIColor(hex: "6475CC")
            static let leadingIndent: CGFloat = 14
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
        enum HabitImage {
            static let tintColor: UIColor = .white
            static let sizeMultiplier: CGFloat = 0.8
            static let contentMode: UIImageView.ContentMode = .scaleAspectFit
        }
        
        enum HabitTitle {
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 8
        }
        
        enum ChevronRight {
            static let imageName: String = "chevron.right"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = .white
        }
    }
    
    static let reuseId: String = "HabitCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let checkmarkButton: ExtendedHitButton = ExtendedHitButton(type: .custom)
    private let habitImageWrap: UIView = UIView()
    private let habitImage: UIImageView = UIImageView()
    private let habitTitle: UILabel = UILabel()
    private let chevronRight: UIImageView = UIImageView()
    
    // MARK: - Properties
    private var isCheckmarkVisible: Bool = false
    var onCheckmarkTapped: ((HabitModel) -> Void)?
    private var habit: HabitModel?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isCheckmarkVisible = false
        checkmarkButton.backgroundColor = Constants.CheckmarkButton.unselectedBgColor
        checkmarkButton.setImage(nil, for: .normal)
    }
    
    // MARK: - Public Methods
    func configure(with habit: HabitModel) {
        self.habit = habit
        guard let title = habit.title else { return }
        guard let color = habit.color else { return }
        guard let iconName = habit.icon else { return }
        guard let currentQuantity = habit.current_quantity else { return }
        guard let targetQuantity = habit.quantity else { return }
        
        let image = UIImage(systemName: iconName)
        
        habitTitle.text = title
        habitImage.image = image
        habitImageWrap.backgroundColor = UIColor(hex: color)
        
        // Сбрасываем состояние кнопки
        isCheckmarkVisible = false
        checkmarkButton.backgroundColor = Constants.CheckmarkButton.unselectedBgColor
        checkmarkButton.setImage(nil, for: .normal)
        
        if currentQuantity >= targetQuantity {
            isCheckmarkVisible = true
            let image = UIImage(named: Constants.CheckmarkButton.imageName)?
                .withRenderingMode(.alwaysOriginal)
                .resize(to: CGSize(
                    width: Constants.CheckmarkButton.imageWidth,
                    height: Constants.CheckmarkButton.imageHeight
                ))
            checkmarkButton.setImage(image, for: .normal)
            checkmarkButton.backgroundColor = Constants.CheckmarkButton.selectedBgColor
        }
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureCheckmarkButton()
        configureHabitImageWrap()
        configureHabitImage()
        configureHabitTitle()
        configureChevronRight()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        
        wrap.layer.shadowColor = Constants.Wrap.shadowColor
        wrap.layer.shadowOpacity = Constants.Wrap.shadowOpacity
        wrap.layer.shadowOffset = CGSize(width: Constants.Wrap.shadowOffsetX, height: Constants.Wrap.shadowOffsetY)
        wrap.layer.shadowRadius = Constants.Wrap.shadowRadius
        wrap.layer.masksToBounds = false
        
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor, Constants.Wrap.bottomIndent)
        wrap.pinLeft(to: contentView.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinRight(to: contentView.trailingAnchor, Constants.Wrap.trailingIndent)
    }
    
    private func configureCheckmarkButton() {
        wrap.addSubview(checkmarkButton)
        
        checkmarkButton.backgroundColor = Constants.CheckmarkButton.unselectedBgColor
        checkmarkButton.layer.cornerRadius = Constants.CheckmarkButton.cornerRadius
        checkmarkButton.setImage(nil, for: .normal)
        checkmarkButton.addTarget(self, action: #selector(checkmarkButtonPressed), for: .touchUpInside)
        checkmarkButton.layer.shadowColor = Constants.CheckmarkButton.shadowColor
        checkmarkButton.layer.shadowOpacity = Constants.CheckmarkButton.shadowOpacity
        checkmarkButton.layer.shadowOffset = CGSize(width: Constants.CheckmarkButton.shadowOffsetX, height: Constants.CheckmarkButton.shadowOffsetY)
        checkmarkButton.layer.shadowRadius = Constants.CheckmarkButton.shadowRadius
        checkmarkButton.layer.masksToBounds = false
        
        checkmarkButton.setHeight(Constants.CheckmarkButton.height)
        checkmarkButton.setWidth(Constants.CheckmarkButton.width)
        
        checkmarkButton.pinCenterY(to: wrap.centerYAnchor)
        checkmarkButton.pinLeft(to: wrap.leadingAnchor, Constants.CheckmarkButton.leadingIndent)
    }
    
    private func configureHabitImageWrap() {
        wrap.addSubview(habitImageWrap)
        
        habitImageWrap.backgroundColor = Constants.HabitImageWrap.bgColor
        habitImageWrap.layer.cornerRadius = Constants.HabitImageWrap.cornerRadius
        habitImageWrap.layer.shadowColor = Constants.HabitImageWrap.shadowColor
        habitImageWrap.layer.shadowOpacity = Constants.HabitImageWrap.shadowOpacity
        habitImageWrap.layer.shadowOffset = CGSize(width: Constants.HabitImageWrap.shadowOffsetX, height: Constants.HabitImageWrap.shadowOffsetY)
        habitImageWrap.layer.shadowRadius = Constants.HabitImageWrap.shadowRadius
        habitImageWrap.layer.masksToBounds = false
        
        habitImageWrap.setHeight(Constants.HabitImageWrap.height)
        habitImageWrap.setWidth(Constants.HabitImageWrap.width)
        
        habitImageWrap.pinCenterY(to: wrap.centerYAnchor)
        habitImageWrap.pinLeft(to: checkmarkButton.trailingAnchor, Constants.HabitImageWrap.leadingIndent)
    }
    
    private func configureHabitImage() {
        habitImageWrap.addSubview(habitImage)
        
        habitImage.tintColor = Constants.HabitImage.tintColor
        
        habitImage.contentMode = Constants.HabitImage.contentMode
        
        habitImage.pinCenterX(to: habitImageWrap.centerXAnchor)
        habitImage.pinCenterY(to: habitImageWrap.centerYAnchor)
        habitImage.pinWidth(to: habitImageWrap.widthAnchor, Constants.HabitImage.sizeMultiplier)
        habitImage.pinHeight(to: habitImageWrap.heightAnchor, Constants.HabitImage.sizeMultiplier)
        
        let configuration = UIImage.SymbolConfiguration(scale: .medium)
        habitImage.preferredSymbolConfiguration = configuration
    }
    
    private func configureHabitTitle() {
        wrap.addSubview(habitTitle)
        
        habitTitle.textColor = Constants.HabitTitle.textColor
        habitTitle.textAlignment = Constants.HabitTitle.textAlignment
        habitTitle.numberOfLines = Constants.HabitTitle.numberOfLines
        
        habitTitle.pinCenterY(to: wrap.centerYAnchor)
        habitTitle.pinLeft(to: habitImageWrap.trailingAnchor, Constants.HabitTitle.leadingIndent)
    }
    
    private func configureChevronRight() {
        wrap.addSubview(chevronRight)
        
        chevronRight.image = UIImage(systemName: Constants.ChevronRight.imageName)
        chevronRight.tintColor = Constants.ChevronRight.tintColor
        
        chevronRight.pinCenterY(to: wrap.centerYAnchor)
        chevronRight.pinRight(to: wrap.trailingAnchor, Constants.ChevronRight.trailingIndent)
    }
    
    private func updateCheckmarkAppearance() {
        if isCheckmarkVisible {
            let image = UIImage(named: Constants.CheckmarkButton.imageName)?
                .withRenderingMode(.alwaysOriginal)
                .resize(to: CGSize(
                    width: Constants.CheckmarkButton.imageWidth,
                    height: Constants.CheckmarkButton.imageHeight
                ))
            checkmarkButton.setImage(image, for: .normal)
            checkmarkButton.backgroundColor = Constants.CheckmarkButton.selectedBgColor
        } else {
            checkmarkButton.backgroundColor = Constants.CheckmarkButton.unselectedBgColor
            checkmarkButton.setImage(nil, for: .normal)
        }
    }
    
    // MARK: - Actions
    @objc
    private func checkmarkButtonPressed() {
        guard var updatedHabit = habit else { return }
        
        if let current = updatedHabit.current_quantity,
           let target = updatedHabit.quantity,
           let currentInt = Int(current),
           let targetInt = Int(target) {
            if currentInt < targetInt { // Привычка выполнена
                updatedHabit.current_quantity = target
                isCheckmarkVisible = true
                updateCheckmarkAppearance()
            } else { // Привычка сброшена
                updatedHabit.current_quantity = "0"
                isCheckmarkVisible = false
                updateCheckmarkAppearance()
            }
            
            onCheckmarkTapped?(updatedHabit)
        }
    }
}
