//
//  AppLanguageCell 2.swift
//  Doordie
//
//  Created by Arseniy on 29.01.2025.
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
        
        enum ChevronRight {
            static let imageName: String = "chevron.right"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = .white
        }
        
        enum LanguageImage {
            static let imageName: String = ""
            static let imageSide: CGFloat = 24
            static let leadingIndent: CGFloat = 18
        }
        
        enum AppLanguageLabel {
            static let text: String = "App language"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .regular
            static let fontSize: CGFloat = 22
            static let leadingIndent: CGFloat = 12
        }
        
        enum CurrentAppLanguageLabel {
            static let textColor: UIColor = UIColor(hex: "B3B3B3")
            static let textAlignment: NSTextAlignment = .right
            static let fontSize: CGFloat = 22
            static let fontWeight: UIFont.Weight = .light
            static let trailingIndent: CGFloat = 2
        }
    }
    
    static let reuseId: String = "AppLanguageCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevronRight: UIImageView = UIImageView()
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
        languageImage.image = UIImage(named: "profileImage")
        appLanguageLabel.text = "Dinarikk <3"
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureChevronRight()
        configureLanguageImage()
        configureAppLanguageLabel()
        configureCurrentAppLanguageLabel()
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
    
    private func configureLanguageImage() {
        wrap.addSubview(languageImage)
        
        languageImage.image = UIImage(systemName: Constants.LanguageImage.imageName)
        languageImage.clipsToBounds = true
        languageImage.setWidth(Constants.LanguageImage.imageSide)
        languageImage.setHeight(Constants.LanguageImage.imageSide)
        
        languageImage.pinCenterY(to: wrap.centerYAnchor)
        languageImage.pinLeft(to: wrap.leadingAnchor, Constants.LanguageImage.leadingIndent)
    }
    
    private func configureAppLanguageLabel() {
        wrap.addSubview(appLanguageLabel)
        
        appLanguageLabel.textColor = Constants.AppLanguageLabel.textColor
        appLanguageLabel.textAlignment = Constants.AppLanguageLabel.textAlignment
        appLanguageLabel.font = UIFont.systemFont(ofSize: Constants.AppLanguageLabel.fontSize, weight: Constants.AppLanguageLabel.fontWeight)
        
        appLanguageLabel.pinCenterY(to: wrap.centerYAnchor)
        appLanguageLabel.pinLeft(to: languageImage.trailingAnchor, Constants.AppLanguageLabel.leadingIndent)
    }
    
    private func configureCurrentAppLanguageLabel() {
        
    }
}
