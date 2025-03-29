//
//  LogoutCell.swift
//  Doordie
//
//  Created by Arseniy on 29.03.2025.
//

import UIKit

final class LogoutCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 55
            static let bgColor: UIColor = .clear
            static let cornerRadius: CGFloat = 20
            static let borderWidth: CGFloat = 2
            static let borderColor: CGColor = UIColor(hex: "F55540").cgColor
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
        }
        
        enum LogoutImage {
            static let imageName: String = "door.right.hand.open"
            static let tintColor: UIColor = UIColor(hex: "F55540")
            static let imageSide: CGFloat = 24
        }
        
        enum LogoutLabel {
            static let text: String = "Logout"
            static let textColor: UIColor = UIColor(hex: "F55540")
            static let textAlignment: NSTextAlignment = .left
            static let font: UIFont = .systemFont(ofSize: 18, weight: .medium)
        }
        
        enum Stack {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let distribution: UIStackView.Distribution = .equalSpacing
            static let alignment: UIStackView.Alignment = .center
            static let spacing: CGFloat = 12
        }
    }
    
    static let reuseId: String = "LogoutCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let logoutImage: UIImageView = UIImageView()
    private let logoutLabel: UILabel = UILabel()
    private let stack: UIStackView = UIStackView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureLogoutImage()
        configureLogoutLabel()
        configureStack()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.borderWidth = Constants.Wrap.borderWidth
        wrap.layer.borderColor = Constants.Wrap.borderColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinRight(to: contentView.trailingAnchor, Constants.Wrap.trailingIndent)
    }
    
    private func configureLogoutImage() {
        logoutImage.image = UIImage(systemName: Constants.LogoutImage.imageName)
        logoutImage.tintColor = Constants.LogoutImage.tintColor
        logoutImage.clipsToBounds = true
        logoutImage.setWidth(Constants.LogoutImage.imageSide)
        logoutImage.setHeight(Constants.LogoutImage.imageSide)
    }
    
    private func configureLogoutLabel() {
        logoutLabel.text = Constants.LogoutLabel.text
        logoutLabel.textColor = Constants.LogoutLabel.textColor
        logoutLabel.textAlignment = Constants.LogoutLabel.textAlignment
        logoutLabel.font = Constants.LogoutLabel.font
    }
    
    private func configureStack() {
        wrap.addSubview(stack)
        stack.addArrangedSubview(logoutImage)
        stack.addArrangedSubview(logoutLabel)
        
        stack.axis = Constants.Stack.axis
        stack.distribution = Constants.Stack.distribution
        stack.alignment = Constants.Stack.alignment
        stack.spacing = Constants.Stack.spacing
        
        stack.pinCenterY(to: wrap.centerYAnchor)
        stack.pinCenterX(to: wrap.centerXAnchor)
    }
}
