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
        }
        
        enum HabitImageWrap {
            static let height: CGFloat = 46
            static let width: CGFloat = 46
            static let cornerRadius: CGFloat = 14
            static let bgColor: UIColor = UIColor(hex: "6475CC")
            static let leadingIndent: CGFloat = 14
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
    private var isCompleted: Bool = false
    
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
        
        if currentQuantity == targetQuantity {
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
        
        checkmarkButton.setHeight(Constants.CheckmarkButton.height)
        checkmarkButton.setWidth(Constants.CheckmarkButton.width)
        
        checkmarkButton.pinCenterY(to: wrap.centerYAnchor)
        checkmarkButton.pinLeft(to: wrap.leadingAnchor, Constants.CheckmarkButton.leadingIndent)
    }
    
    private func configureHabitImageWrap() {
        wrap.addSubview(habitImageWrap)
        
        habitImageWrap.backgroundColor = Constants.HabitImageWrap.bgColor
        habitImageWrap.layer.cornerRadius = Constants.HabitImageWrap.cornerRadius
        
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
    
    // MARK: - Actions
    @objc
    private func checkmarkButtonPressed() {
        isCheckmarkVisible.toggle() // Переключаем состояние
        if isCheckmarkVisible {
            let image = UIImage(named: Constants.CheckmarkButton.imageName)?.withRenderingMode(.alwaysOriginal)
            let resizedImage = image?.resize(to: CGSize(width: Constants.CheckmarkButton.imageWidth, height: Constants.CheckmarkButton.imageHeight))
            checkmarkButton.setImage(resizedImage, for: .normal)
            checkmarkButton.backgroundColor = Constants.CheckmarkButton.selectedBgColor
        } else {
            checkmarkButton.backgroundColor = Constants.CheckmarkButton.unselectedBgColor
            checkmarkButton.setImage(nil, for: .normal) // Убираем изображение
        }
    }
}
