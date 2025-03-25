//
//  PopupHabitViewController.swift
//  Doordie
//
//  Created by Arseniy on 25.03.2025.
//

import UIKit

final class PopupHabitViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let cornerRadius: CGFloat = 12
            static let backgroundColor: UIColor = UIColor(hex: "3A50C2")
        }
        
        enum HabitImageWrap {
            static let height: CGFloat = 46
            static let width: CGFloat = 46
            static let cornerRadius: CGFloat = 14
            static let bgColor: UIColor = UIColor(hex: "6475CC")
            static let bgColorHex: String = "6475CC"
            static let topIndent: CGFloat = 8
        }
        
        enum HabitImage {
            static let imageName: String = "heart"
            static let tintColor: UIColor = .white
            static let width: CGFloat = 36
        }
        
        enum TitleLabel {
            static let font: UIFont = .systemFont(ofSize: 20, weight: .bold)
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
            static let topIndent: CGFloat = 8
        }
        
        enum MotivationsLabel {
            static let font: UIFont = .systemFont(ofSize: 16, weight: .regular)
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let topIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 8
        }
        
        enum RegularityLabel {
            static let font: UIFont = .systemFont(ofSize: 16, weight: .regular)
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let topIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 8
        }
        
    }
    
    // MARK: - UI Components
    private let habitImageWrap: UIView = UIView()
    private let habitImage: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let motivationsLabel: UILabel = UILabel()
    private let regularityLabel: UILabel = UILabel()
    
    // MARK: - Properties
    override var preferredContentSize: CGSize {
        get { CGSize(width: 300, height: 200) }
        set { super.preferredContentSize = newValue }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods
    func configure(with habit: HabitModel) {
        // title
        titleLabel.text = habit.title
        if let motivations = habit.motivations, motivations.isEmpty == false {
            motivationsLabel.text = "Motivations: \(motivations)"
        }
        if let regularity = habit.regularity, regularity.isEmpty == false {
            regularityLabel.text = "Regularity: \(regularity)"
        }
        habitImageWrap.backgroundColor = UIColor(hex: habit.color ?? Constants.HabitImageWrap.bgColorHex)
        habitImage.image = UIImage(systemName: habit.icon ?? Constants.HabitImage.imageName)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureHabitImageWrap()
        configureHabitImage()
        configureTitleLabel()
        configureMotivationsLabel()
        configureRegularityLabel()
    }
    
    private func configureBackground() {
        view.layer.cornerRadius = Constants.Background.cornerRadius
        view.clipsToBounds = true
        view.backgroundColor = Constants.Background.backgroundColor
        view.isUserInteractionEnabled = true
    }
    
    private func configureHabitImageWrap() {
        view.addSubview(habitImageWrap)
        
        habitImageWrap.layer.cornerRadius = Constants.HabitImageWrap.cornerRadius
        
        habitImageWrap.setHeight(Constants.HabitImageWrap.height)
        habitImageWrap.setWidth(Constants.HabitImageWrap.width)
        
        habitImageWrap.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        habitImageWrap.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.HabitImageWrap.topIndent)
    }
    
    private func configureHabitImage() {
        habitImageWrap.addSubview(habitImage)
        
        habitImage.tintColor = Constants.HabitImage.tintColor
        
        habitImage.contentMode = .scaleAspectFill
        habitImage.setWidth(Constants.HabitImage.width)
        
        habitImage.pinCenterX(to: habitImageWrap.centerXAnchor)
        habitImage.pinCenterY(to: habitImageWrap.centerYAnchor)
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.font = Constants.TitleLabel.font
        titleLabel.textColor = Constants.TitleLabel.textColor
        titleLabel.textAlignment = Constants.TitleLabel.textAlignment
        
        titleLabel.pinTop(to: habitImageWrap.safeAreaLayoutGuide.bottomAnchor, Constants.TitleLabel.topIndent)
        titleLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
    }
    
    private func configureMotivationsLabel() {
        view.addSubview(motivationsLabel)
        
        motivationsLabel.font = Constants.MotivationsLabel.font
        motivationsLabel.textColor = Constants.MotivationsLabel.textColor
        motivationsLabel.textAlignment = Constants.MotivationsLabel.textAlignment
        
        motivationsLabel.pinTop(to: titleLabel.bottomAnchor, Constants.MotivationsLabel.topIndent)
        motivationsLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.MotivationsLabel.leadingIndent)
    }
    
    private func configureRegularityLabel() {
        view.addSubview(regularityLabel)
        
        regularityLabel.font = Constants.RegularityLabel.font
        regularityLabel.textColor = Constants.RegularityLabel.textColor
        regularityLabel.textAlignment = Constants.RegularityLabel.textAlignment
        
        regularityLabel.pinTop(to: motivationsLabel.bottomAnchor, Constants.RegularityLabel.topIndent)
        regularityLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.RegularityLabel.leadingIndent)
    }
}

