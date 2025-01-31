//
//  TelegramLinkCell.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//

import UIKit

final class TelegramLinkCell: UITableViewCell {
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
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
        }
        
        enum Chevron {
            static let imageName: String = "square.and.arrow.up"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = UIColor(hex: "B3B3B3")
        }
        
        enum TelegramLogoImage {
            static let imageName: String = "telegram.logo"
            static let tintColor: UIColor = .white
            static let imageSide: CGFloat = 24
            static let leadingIndent: CGFloat = 18
        }
        
        enum FollowLabel {
            static let text: String = "Follow us on telegram!"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .medium
            static let fontSize: CGFloat = 18
            static let leadingIndent: CGFloat = 12
        }
    }
    
    static let reuseId: String = "TelegramLinkCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevron: UIImageView = UIImageView()
    private let telegramLogoImage: UIImageView = UIImageView()
    private let followLabel: UILabel = UILabel()
    
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
        configureChevron()
        configureTelegramLogoImage()
        configureFollowLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrap.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinRight(to: contentView.trailingAnchor, Constants.Wrap.trailingIndent)
    }
    
    private func configureChevron() {
        wrap.addSubview(chevron)
        
        chevron.image = UIImage(systemName: Constants.Chevron.imageName)
        chevron.tintColor = Constants.Chevron.tintColor
        
        chevron.pinCenterY(to: wrap.centerYAnchor)
        chevron.pinRight(to: wrap.trailingAnchor, Constants.Chevron.trailingIndent)
    }
    
    private func configureTelegramLogoImage() {
        wrap.addSubview(telegramLogoImage)
        
        telegramLogoImage.image = UIImage(named: Constants.TelegramLogoImage.imageName)
        telegramLogoImage.tintColor = Constants.TelegramLogoImage.tintColor
        telegramLogoImage.clipsToBounds = true
        telegramLogoImage.setWidth(Constants.TelegramLogoImage.imageSide)
        telegramLogoImage.setHeight(Constants.TelegramLogoImage.imageSide)
        
        telegramLogoImage.pinCenterY(to: wrap.centerYAnchor)
        telegramLogoImage.pinLeft(to: wrap.leadingAnchor, Constants.TelegramLogoImage.leadingIndent)
    }
    
    private func configureFollowLabel() {
        wrap.addSubview(followLabel)
        
        followLabel.text = Constants.FollowLabel.text
        followLabel.textColor = Constants.FollowLabel.textColor
        followLabel.textAlignment = Constants.FollowLabel.textAlignment
        followLabel.font = UIFont.systemFont(ofSize: Constants.FollowLabel.fontSize, weight: Constants.FollowLabel.fontWeight)
        
        followLabel.pinCenterY(to: wrap.centerYAnchor)
        followLabel.pinLeft(to: telegramLogoImage.trailingAnchor, Constants.FollowLabel.leadingIndent)
    }
}

