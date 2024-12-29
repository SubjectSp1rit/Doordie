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
        // UI
        static let contentViewBgColor: UIColor = .clear
        static let cellBgColor: UIColor = .clear
        static let contentViewHeight: CGFloat = 60
        
        // todayLabel
        static let todayLabelText: String = "Today"
        static let todayLabelTextAlignment: NSTextAlignment = .left
        static let todayLabeTextColor: UIColor = .white
        static let todayLabelFontSize: CGFloat = 48
        static let todayLabelNumberOfLines: Int = 1
        
        // currentDateLabel
        static let currentDateLabelText: String = "December 31"
        static let currentDateLabelTextAlignment: NSTextAlignment = .left
        static let currentDateLabeTextColor: UIColor = .lightGray.withAlphaComponent(0.85)
        static let currentDateLabelFontSize: CGFloat = 22
        static let currentDateLabelNumberOfLines: Int = 1
        
        // profileImage
        static let profileImageName: String = "profileImage"
        static let profileImageCornerRadius: CGFloat = 30
        static let profileImageSide: CGFloat = 60
        
        // stack
        static let stackSpacing: CGFloat = 0
        static let stackLeadingIndent: CGFloat = 18
        
        // labelsStack
        static let labelsStackSpacing: CGFloat = 2
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
        
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.cellBgColor
        contentView.backgroundColor = Constants.contentViewBgColor
        
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
        
        stack.axis = .horizontal
        stack.spacing = Constants.stackSpacing
        stack.distribution = .fill
        stack.alignment = .center
        
        
        stack.pinLeft(to: contentView.leadingAnchor, Constants.stackLeadingIndent)
        stack.pinCenterX(to: contentView.centerXAnchor)
        stack.pinTop(to: contentView.topAnchor)
        stack.setHeight(Constants.contentViewHeight)
        stack.pinBottom(to: contentView.bottomAnchor)
    }
    
    private func configureTodayLabel() {
        todayLabel.textAlignment = Constants.todayLabelTextAlignment
        todayLabel.textColor = Constants.todayLabeTextColor
        todayLabel.text = Constants.todayLabelText
        todayLabel.font = UIFont.systemFont(ofSize: Constants.todayLabelFontSize, weight: .semibold)
        todayLabel.numberOfLines = Constants.todayLabelNumberOfLines
        todayLabel.setContentHuggingPriority(.required, for: .horizontal)
        todayLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func configureCurrentDateLabel() {
        currentDateLabel.textAlignment = Constants.currentDateLabelTextAlignment
        currentDateLabel.textColor = Constants.currentDateLabeTextColor
        currentDateLabel.text = Constants.currentDateLabelText
        currentDateLabel.font = UIFont.systemFont(ofSize: Constants.currentDateLabelFontSize)
        currentDateLabel.numberOfLines = Constants.currentDateLabelNumberOfLines
        currentDateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        currentDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func configureProfileImage() {
        profileImage.image = UIImage(named: Constants.profileImageName)
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.cornerRadius = Constants.profileImageCornerRadius
        profileImage.clipsToBounds = true
        profileImage.setWidth(Constants.profileImageSide)
        profileImage.setHeight(Constants.profileImageSide)
    }
    
    private func configureLabelsStack() {
        labelsStack.addArrangedSubview(todayLabel)
        labelsStack.addArrangedSubview(currentDateLabel)
        labelsStack.axis = .horizontal
        labelsStack.spacing = Constants.labelsStackSpacing
        labelsStack.alignment = .center
        labelsStack.distribution = .fillProportionally
    }
    
    // MARK: - Actions
    @objc
    private func profileImageTapped() {
        onProfileImageTapped?()
    }
}
