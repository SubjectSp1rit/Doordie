//
//  AppThemeCell.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//

import UIKit

final class AppThemeCell: UITableViewCell {
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
        
        enum ThemeImage {
            static let imageName: String = "sun.max"
            static let tintColor: UIColor = .white
            static let imageSide: CGFloat = 24
            static let leadingIndent: CGFloat = 18
        }
        
        enum AppThemeLabel {
            static let text: String = "App theme"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .medium
            static let fontSize: CGFloat = 18
            static let leadingIndent: CGFloat = 12
        }
        
        enum CurrentAppThemeLabel {
            static let textColor: UIColor = UIColor(hex: "B3B3B3")
            static let textAlignment: NSTextAlignment = .right
            static let fontSize: CGFloat = 18
            static let fontWeight: UIFont.Weight = .light
            static let trailingIndent: CGFloat = 2
        }
    }
    
    static let reuseId: String = "AppThemeCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevron: UIImageView = UIImageView()
    private let themeImage: UIImageView = UIImageView()
    private let appThemeLabel: UILabel = UILabel()
    private let currentAppThemeLabel: UILabel = UILabel()
    
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
        currentAppThemeLabel.text = "Ultramarine"
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureChevron()
        configureThemeImage()
        configureAppThemeLabel()
        configureCurrentAppThemeLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrap.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
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
    
    private func configureThemeImage() {
        wrap.addSubview(themeImage)
        
        themeImage.image = UIImage(systemName: Constants.ThemeImage.imageName)
        themeImage.tintColor = Constants.ThemeImage.tintColor
        themeImage.clipsToBounds = true
        themeImage.setWidth(Constants.ThemeImage.imageSide)
        themeImage.setHeight(Constants.ThemeImage.imageSide)
        
        themeImage.pinCenterY(to: wrap.centerYAnchor)
        themeImage.pinLeft(to: wrap.leadingAnchor, Constants.ThemeImage.leadingIndent)
    }
    
    private func configureAppThemeLabel() {
        wrap.addSubview(appThemeLabel)
        
        appThemeLabel.text = Constants.AppThemeLabel.text
        appThemeLabel.textColor = Constants.AppThemeLabel.textColor
        appThemeLabel.textAlignment = Constants.AppThemeLabel.textAlignment
        appThemeLabel.font = UIFont.systemFont(ofSize: Constants.AppThemeLabel.fontSize, weight: Constants.AppThemeLabel.fontWeight)
        
        appThemeLabel.pinCenterY(to: wrap.centerYAnchor)
        appThemeLabel.pinLeft(to: themeImage.trailingAnchor, Constants.AppThemeLabel.leadingIndent)
    }
    
    private func configureCurrentAppThemeLabel() {
        wrap.addSubview(currentAppThemeLabel)
        
        currentAppThemeLabel.textColor = Constants.CurrentAppThemeLabel.textColor
        currentAppThemeLabel.textAlignment = Constants.CurrentAppThemeLabel.textAlignment
        currentAppThemeLabel.font = UIFont.systemFont(ofSize: Constants.CurrentAppThemeLabel.fontSize, weight: Constants.CurrentAppThemeLabel.fontWeight)
        
        currentAppThemeLabel.pinCenterY(to: wrap.centerYAnchor)
        currentAppThemeLabel.pinRight(to: chevron.leadingAnchor, Constants.CurrentAppThemeLabel.trailingIndent)
    }
}

