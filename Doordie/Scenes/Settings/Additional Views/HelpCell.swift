//
//  HelpCell.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//

import UIKit

final class AppLanguageCell: UITableViewCell {
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
            static let imageName: String = "chevron.up.chevron.down"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = UIColor(hex: "B3B3B3")
        }
        
        enum LanguageImage {
            static let imageName: String = "globe"
            static let tintColor: UIColor = .white
            static let imageSide: CGFloat = 24
            static let leadingIndent: CGFloat = 18
        }
        
        enum AppLanguageLabel {
            static let text: String = "App language"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .medium
            static let fontSize: CGFloat = 18
            static let leadingIndent: CGFloat = 12
        }
        
        enum CurrentAppLanguageLabel {
            static let textColor: UIColor = UIColor(hex: "B3B3B3")
            static let textAlignment: NSTextAlignment = .right
            static let fontSize: CGFloat = 18
            static let fontWeight: UIFont.Weight = .light
            static let trailingIndent: CGFloat = 2
        }
    }
    
    static let reuseId: String = "AppLanguageCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevron: UIImageView = UIImageView()
    private let languageImage: UIImageView = UIImageView()
    private let appLanguageLabel: UILabel = UILabel()
    private let currentAppLanguageLabel: UILabel = UILabel()
    
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
        currentAppLanguageLabel.text = "English"
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureChevron()
        configureLanguageImage()
        configureAppLanguageLabel()
        configureCurrentAppLanguageLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrap.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
    
    private func configureLanguageImage() {
        wrap.addSubview(languageImage)
        
        languageImage.image = UIImage(systemName: Constants.LanguageImage.imageName)
        languageImage.tintColor = Constants.LanguageImage.tintColor
        languageImage.clipsToBounds = true
        languageImage.setWidth(Constants.LanguageImage.imageSide)
        languageImage.setHeight(Constants.LanguageImage.imageSide)
        
        languageImage.pinCenterY(to: wrap.centerYAnchor)
        languageImage.pinLeft(to: wrap.leadingAnchor, Constants.LanguageImage.leadingIndent)
    }
    
    private func configureAppLanguageLabel() {
        wrap.addSubview(appLanguageLabel)
        
        appLanguageLabel.text = Constants.AppLanguageLabel.text
        appLanguageLabel.textColor = Constants.AppLanguageLabel.textColor
        appLanguageLabel.textAlignment = Constants.AppLanguageLabel.textAlignment
        appLanguageLabel.font = UIFont.systemFont(ofSize: Constants.AppLanguageLabel.fontSize, weight: Constants.AppLanguageLabel.fontWeight)
        
        appLanguageLabel.pinCenterY(to: wrap.centerYAnchor)
        appLanguageLabel.pinLeft(to: languageImage.trailingAnchor, Constants.AppLanguageLabel.leadingIndent)
    }
    
    private func configureCurrentAppLanguageLabel() {
        wrap.addSubview(currentAppLanguageLabel)
        
        currentAppLanguageLabel.textColor = Constants.CurrentAppLanguageLabel.textColor
        currentAppLanguageLabel.textAlignment = Constants.CurrentAppLanguageLabel.textAlignment
        currentAppLanguageLabel.font = UIFont.systemFont(ofSize: Constants.CurrentAppLanguageLabel.fontSize, weight: Constants.CurrentAppLanguageLabel.fontWeight)
        
        currentAppLanguageLabel.pinCenterY(to: wrap.centerYAnchor)
        currentAppLanguageLabel.pinRight(to: chevron.leadingAnchor, Constants.CurrentAppLanguageLabel.trailingIndent)
    }
}

