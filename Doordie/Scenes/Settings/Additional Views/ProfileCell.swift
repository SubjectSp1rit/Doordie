//
//  ProfileCell.swift
//  Doordie
//
//  Created by Arseniy on 25.01.2025.
//

import UIKit

final class ProfileCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 90
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
        }
        
        enum ChevronRight {
            static let imageName: String = "chevron.right"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = .white
        }
        
        enum ProfileImage {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let cornerRadius: CGFloat = 30
            static let imageSide: CGFloat = 60
            static let leadingIndent: CGFloat = 18
        }
        
        enum NameLabel {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .regular
            static let fontSize: CGFloat = 22
            static let leadingIndent: CGFloat = 12
        }
    }
    
    static let reuseId: String = "ProfileCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevronRight: UIImageView = UIImageView()
    private let profileImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    
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
        profileImage.image = UIImage(named: "profileImage")
        nameLabel.text = "User"
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureChevronRight()
        configureProfileImage()
        configureNameLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinRight(to: contentView.trailingAnchor, Constants.Wrap.trailingIndent)
    }
    
    private func configureChevronRight() {
        wrap.addSubview(chevronRight)
        
        chevronRight.image = UIImage(systemName: Constants.ChevronRight.imageName)
        chevronRight.tintColor = Constants.ChevronRight.tintColor
        
        chevronRight.pinCenterY(to: wrap.centerYAnchor)
        chevronRight.pinRight(to: wrap.trailingAnchor, Constants.ChevronRight.trailingIndent)
    }
    
    private func configureProfileImage() {
        wrap.addSubview(profileImage)
        
        profileImage.contentMode = Constants.ProfileImage.contentMode
        profileImage.layer.cornerRadius = Constants.ProfileImage.cornerRadius
        profileImage.clipsToBounds = true
        profileImage.setWidth(Constants.ProfileImage.imageSide)
        profileImage.setHeight(Constants.ProfileImage.imageSide)
        
        profileImage.pinCenterY(to: wrap.centerYAnchor)
        profileImage.pinLeft(to: wrap.leadingAnchor, Constants.ProfileImage.leadingIndent)
    }
    
    private func configureNameLabel() {
        wrap.addSubview(nameLabel)
        
        nameLabel.textColor = Constants.NameLabel.textColor
        nameLabel.textAlignment = Constants.NameLabel.textAlignment
        nameLabel.font = UIFont.systemFont(ofSize: Constants.NameLabel.fontSize, weight: Constants.NameLabel.fontWeight)
        
        nameLabel.pinCenterY(to: wrap.centerYAnchor)
        nameLabel.pinLeft(to: profileImage.trailingAnchor, Constants.NameLabel.leadingIndent)
    }
}
