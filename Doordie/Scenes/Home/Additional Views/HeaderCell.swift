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
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 48
            static let numberOfLines: Int = 1
        }
        
        enum CurrentDateLabel {
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .lightGray.withAlphaComponent(0.85)
            static let fontSize: CGFloat = 22
            static let numberOfLines: Int = 1
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
        }
    }
    
    static let reuseId: String = "HeaderCell"
    
    // MARK: - UI Components
    private let stack: UIStackView = UIStackView()
    private let labelsStack: UIStackView = UIStackView()
    private let todayLabel: UILabel = UILabel()
    private let currentDateLabel: UILabel = UILabel()
    private let profileImage: UIImageView = UIImageView()
    
    // MARK: - Variables
    var onProfileImageTapped: (() -> Void)?
    
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
    func configure() {
        currentDateLabel.text = "December 31"
        profileImage.image = UIImage(named: "profileImage")
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
        todayLabel.textColor = Constants.TodayLabel.textColor
        todayLabel.text = Constants.TodayLabel.text
        todayLabel.font = UIFont.systemFont(ofSize: Constants.TodayLabel.fontSize, weight: Constants.TodayLabel.fontWeight)
        todayLabel.numberOfLines = Constants.TodayLabel.numberOfLines
        todayLabel.setContentHuggingPriority(.required, for: .horizontal)
        todayLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func configureCurrentDateLabel() {
        currentDateLabel.textAlignment = Constants.CurrentDateLabel.textAlignment
        currentDateLabel.textColor = Constants.CurrentDateLabel.textColor
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
    }
    
    private func configureLabelsStack() {
        labelsStack.addArrangedSubview(todayLabel)
        labelsStack.addArrangedSubview(currentDateLabel)
        labelsStack.axis = Constants.LabelsStack.axis
        labelsStack.spacing = Constants.LabelsStack.spacing
        labelsStack.alignment = Constants.LabelsStack.alignment
        labelsStack.distribution = Constants.LabelsStack.distribution
    }
    
    // MARK: - Actions
    @objc
    private func profileImageTapped() {
        onProfileImageTapped?()
    }
}
