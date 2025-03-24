//
//  headerCell.swift
//  Doordie
//
//  Created by Arseniy on 29.12.2024.
//

import Foundation
import UIKit

final class HeaderCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum TodayLabel {
            static let text: String = "Today"
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .semibold
            static let standardTextColor: UIColor = .white
            static let decreasedScaleTextColor: UIColor = .lightGray.withAlphaComponent(0.85)
            static let fontSize: CGFloat = 48
            static let numberOfLines: Int = 1
            
            static let standardScaleX: CGFloat = 1
            static let standardScaleY: CGFloat = 1
            static let decreasedScaleX: CGFloat = 0.46
            static let decreasedScaleY: CGFloat = 0.46
        }
        
        enum CurrentDateLabel {
            static let textAlignment: NSTextAlignment = .left
            static let standardTextColor: UIColor = .lightGray.withAlphaComponent(0.85)
            static let increasedScaleTextColor: UIColor = .white
            static let fontSize: CGFloat = 22
            static let numberOfLines: Int = 1
            
            static let standardScaleX: CGFloat = 1
            static let standardScaleY: CGFloat = 1
            static let increasedScaleX: CGFloat = 1.7
            static let increasedScaleY: CGFloat = 1.7
        }
        
        enum ProfileImage {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let cornerRadius: CGFloat = 30
            static let imageSide: CGFloat = 60
        }
        
        enum Stack {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let distribution: UIStackView.Distribution = .fill
            static let alignment: UIStackView.Alignment = .center
            static let spacing: CGFloat = 0
            static let leadingIndent: CGFloat = 18
            static let height: CGFloat = 60
        }
        
        enum LabelsStack {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let distribution: UIStackView.Distribution = .fillProportionally
            static let alignment: UIStackView.Alignment = .center
            static let spacing: CGFloat = 2
            
            static let xOffsetStandard: CGFloat = 0
            static let yOffsetStandard: CGFloat = 0
            static let xOffsetAfterSwap: CGFloat = -70
            static let yOffsetAfterSwap: CGFloat = 0
        }
        
        enum Animations {
            static let swapDuration: TimeInterval = 0.3
        }
    }
    
    static let reuseId: String = "HeaderCell"
    
    // MARK: - UI Components
    private let stack: UIStackView = UIStackView()
    private let labelsStack: UIStackView = UIStackView()
    private let todayLabel: UILabel = UILabel()
    private let currentDateLabel: UILabel = UILabel()
    private let profileImage: UIImageView = UIImageView()
    private let spacerView: UIView = UIView()
    
    // MARK: - Constraints
    private var isTodayLarge: Bool = true
    
    // MARK: - Variables
    var onProfileImageTapped: (() -> Void)?
    var onTodayLabelTapped: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with date: String) {
        currentDateLabel.text = date
        profileImage.image = UIImage(named: "profileImage")
    }
    
    func swapTodayAndDateLabels() {
        UIView.animate(withDuration: Constants.Animations.swapDuration, animations: {
            if self.isTodayLarge {
                self.todayLabel.transform = CGAffineTransform(scaleX: Constants.TodayLabel.decreasedScaleX, y: Constants.TodayLabel.decreasedScaleY)
                self.todayLabel.textColor = Constants.TodayLabel.decreasedScaleTextColor
                self.currentDateLabel.transform = CGAffineTransform(scaleX: Constants.CurrentDateLabel.increasedScaleX, y: Constants.CurrentDateLabel.increasedScaleY)
                self.currentDateLabel.textColor = Constants.CurrentDateLabel.increasedScaleTextColor
                self.labelsStack.transform = CGAffineTransform(translationX: Constants.LabelsStack.xOffsetAfterSwap, y: Constants.LabelsStack.yOffsetAfterSwap)
            } else {
                self.todayLabel.transform = CGAffineTransform(scaleX: Constants.TodayLabel.standardScaleX, y: Constants.TodayLabel.standardScaleY)
                self.todayLabel.textColor = Constants.TodayLabel.standardTextColor
                self.currentDateLabel.transform = CGAffineTransform(scaleX: Constants.CurrentDateLabel.standardScaleX, y: Constants.CurrentDateLabel.standardScaleY)
                self.currentDateLabel.textColor = Constants.CurrentDateLabel.standardTextColor
                self.labelsStack.transform = CGAffineTransform(translationX: Constants.LabelsStack.xOffsetStandard, y: Constants.LabelsStack.yOffsetStandard)
            }
            
            // Изменяем положение лейблов
            let todayLabelNewCenterX = self.labelsStack.center.x - self.todayLabel.frame.width / 2
            let currentDateLabelNewCenterX = self.labelsStack.center.x + self.currentDateLabel.frame.width / 2
            self.todayLabel.center.x = todayLabelNewCenterX
            self.currentDateLabel.center.x = currentDateLabelNewCenterX
            
            self.layoutIfNeeded()
        })
        isTodayLarge.toggle()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        
        configureStack()
    }
    
    private func configureStack() {
        contentView.addSubview(stack)
        
        configureTodayLabel()
        configureCurrentDateLabel()
        configureProfileImage()
        configureLabelsStack()
        
        stack.addArrangedSubview(labelsStack)
        stack.addArrangedSubview(spacerView)
        stack.addArrangedSubview(profileImage)
        
        stack.axis = Constants.Stack.axis
        stack.spacing = Constants.Stack.spacing
        stack.distribution = Constants.Stack.distribution
        stack.alignment = Constants.Stack.alignment
        
        
        stack.pinLeft(to: contentView.leadingAnchor, Constants.Stack.leadingIndent)
        stack.pinCenterX(to: contentView.centerXAnchor)
        stack.pinTop(to: contentView.topAnchor)
        stack.pinBottom(to: contentView.bottomAnchor)
        stack.setHeight(Constants.Stack.height)
    }
    
    private func configureTodayLabel() {
        todayLabel.textAlignment = Constants.TodayLabel.textAlignment
        todayLabel.textColor = Constants.TodayLabel.standardTextColor
        todayLabel.text = Constants.TodayLabel.text
        todayLabel.font = UIFont.systemFont(ofSize: Constants.TodayLabel.fontSize, weight: Constants.TodayLabel.fontWeight)
        todayLabel.numberOfLines = Constants.TodayLabel.numberOfLines
        todayLabel.setContentHuggingPriority(.required, for: .horizontal)
        todayLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func configureCurrentDateLabel() {
        currentDateLabel.textAlignment = Constants.CurrentDateLabel.textAlignment
        currentDateLabel.textColor = Constants.CurrentDateLabel.standardTextColor
        currentDateLabel.font = UIFont.systemFont(ofSize: Constants.CurrentDateLabel.fontSize)
        currentDateLabel.numberOfLines = Constants.CurrentDateLabel.numberOfLines
        currentDateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        currentDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func configureProfileImage() {
        profileImage.contentMode = Constants.ProfileImage.contentMode
        profileImage.layer.cornerRadius = Constants.ProfileImage.cornerRadius
        profileImage.clipsToBounds = true
        profileImage.setWidth(Constants.ProfileImage.imageSide)
        profileImage.setHeight(Constants.ProfileImage.imageSide)
        
        profileImage.isUserInteractionEnabled = true
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(profileImageTap)
    }
    
    private func configureLabelsStack() {
        labelsStack.addArrangedSubview(todayLabel)
        labelsStack.addArrangedSubview(currentDateLabel)
        labelsStack.axis = Constants.LabelsStack.axis
        labelsStack.spacing = Constants.LabelsStack.spacing
        labelsStack.alignment = Constants.LabelsStack.alignment
        labelsStack.distribution = Constants.LabelsStack.distribution
        
        labelsStack.isUserInteractionEnabled = true
        let todayLabelTap = UITapGestureRecognizer(target: self, action: #selector(todayLabelTapped))
        labelsStack.addGestureRecognizer(todayLabelTap)
    }
    
    // MARK: - Actions
    @objc
    private func profileImageTapped() {
        onProfileImageTapped?()
    }
    
    @objc
    private func todayLabelTapped() {
        onTodayLabelTapped?()
    }
}
