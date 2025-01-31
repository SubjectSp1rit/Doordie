//
//  AppInfoCell.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//

import UIKit

final class AppInfoCell: UITableViewCell {
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
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
        }
        
        enum Chevron {
            static let imageName: String = "chevron.right"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = UIColor(hex: "B3B3B3")
        }
        
        enum AppInfoImage {
            static let imageName: String = "heart"
            static let tintColor: UIColor = .white
            static let imageSide: CGFloat = 24
            static let leadingIndent: CGFloat = 18
        }
        
        enum AppInfoLabel {
            static let text: String = "App info"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .medium
            static let fontSize: CGFloat = 18
            static let leadingIndent: CGFloat = 12
        }
    }
    
    static let reuseId: String = "AppInfoCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevron: UIImageView = UIImageView()
    private let appInfoImage: UIImageView = UIImageView()
    private let appInfoLabel: UILabel = UILabel()
    
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
        configureAppInfoImage()
        configureAppInfoLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        
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
    
    private func configureAppInfoImage() {
        wrap.addSubview(appInfoImage)
        
        appInfoImage.image = UIImage(systemName: Constants.AppInfoImage.imageName)
        appInfoImage.tintColor = Constants.AppInfoImage.tintColor
        appInfoImage.clipsToBounds = true
        appInfoImage.setWidth(Constants.AppInfoImage.imageSide)
        appInfoImage.setHeight(Constants.AppInfoImage.imageSide)
        
        appInfoImage.pinCenterY(to: wrap.centerYAnchor)
        appInfoImage.pinLeft(to: wrap.leadingAnchor, Constants.AppInfoImage.leadingIndent)
    }
    
    private func configureAppInfoLabel() {
        wrap.addSubview(appInfoLabel)
        
        appInfoLabel.text = Constants.AppInfoLabel.text
        appInfoLabel.textColor = Constants.AppInfoLabel.textColor
        appInfoLabel.textAlignment = Constants.AppInfoLabel.textAlignment
        appInfoLabel.font = UIFont.systemFont(ofSize: Constants.AppInfoLabel.fontSize, weight: Constants.AppInfoLabel.fontWeight)
        
        appInfoLabel.pinCenterY(to: wrap.centerYAnchor)
        appInfoLabel.pinLeft(to: appInfoImage.trailingAnchor, Constants.AppInfoLabel.leadingIndent)
    }
}
