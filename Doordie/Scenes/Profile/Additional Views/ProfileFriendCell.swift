//
//  ProfileFriendCell.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

final class ProfileFriendCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 100
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
            static let bottomIndent: CGFloat = 10
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
        enum ProfileImage {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let cornerRadius: CGFloat = 35
            static let imageSide: CGFloat = 70
            static let leadingIndent: CGFloat = 14
        }
        
        enum NameLabel {
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
    
    static let reuseId: String = "ProfileFriendCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let profileImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let chevronRight: UIImageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with friend: ProfileModels.FriendUser) {
        nameLabel.text = friend.name
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureProfileImage()
        configureNameLabel()
        configureChevronRight()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        
        // Тень
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
    
    private func configureProfileImage() {
        wrap.addSubview(profileImage)
        
        profileImage.layer.cornerRadius = Constants.ProfileImage.cornerRadius
        profileImage.contentMode = Constants.ProfileImage.contentMode
        profileImage.clipsToBounds = true
        
        profileImage.image = UIImage(named: "profileImage")
        
        profileImage.pinLeft(to: wrap.leadingAnchor, Constants.ProfileImage.leadingIndent)
        profileImage.pinCenterY(to: wrap.centerYAnchor)
        profileImage.setWidth(Constants.ProfileImage.imageSide)
        profileImage.setHeight(Constants.ProfileImage.imageSide)
    }
    
    private func configureNameLabel() {
        wrap.addSubview(nameLabel)
        
        nameLabel.textColor = Constants.NameLabel.textColor
        nameLabel.textAlignment = Constants.NameLabel.textAlignment
        nameLabel.numberOfLines = Constants.NameLabel.numberOfLines
        
        nameLabel.pinCenterY(to: wrap.centerYAnchor)
        nameLabel.pinLeft(to: profileImage.trailingAnchor, Constants.NameLabel.leadingIndent)
    }
    
    private func configureChevronRight() {
        wrap.addSubview(chevronRight)
        
        chevronRight.image = UIImage(systemName: Constants.ChevronRight.imageName)
        chevronRight.tintColor = Constants.ChevronRight.tintColor
        
        chevronRight.pinCenterY(to: wrap.centerYAnchor)
        chevronRight.pinRight(to: wrap.trailingAnchor, Constants.ChevronRight.trailingIndent)
    }
}
