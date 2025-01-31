//
//  TermsOfUseCell.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//

import UIKit

final class HelpCell: UITableViewCell {
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
            static let imageName: String = "chevron.right"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = UIColor(hex: "B3B3B3")
        }
        
        enum HelpImage {
            static let imageName: String = "questionmark.circle"
            static let tintColor: UIColor = .white
            static let imageSide: CGFloat = 24
            static let leadingIndent: CGFloat = 18
        }
        
        enum HelpLabel {
            static let text: String = "Help"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .medium
            static let fontSize: CGFloat = 18
            static let leadingIndent: CGFloat = 12
        }
    }
    
    static let reuseId: String = "HelpCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevron: UIImageView = UIImageView()
    private let helpImage: UIImageView = UIImageView()
    private let helpLabel: UILabel = UILabel()
    
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
        configureHelpImage()
        configureHelpLabel()
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
    
    private func configureHelpImage() {
        wrap.addSubview(helpImage)
        
        helpImage.image = UIImage(systemName: Constants.HelpImage.imageName)
        helpImage.tintColor = Constants.HelpImage.tintColor
        helpImage.clipsToBounds = true
        helpImage.setWidth(Constants.HelpImage.imageSide)
        helpImage.setHeight(Constants.HelpImage.imageSide)
        
        helpImage.pinCenterY(to: wrap.centerYAnchor)
        helpImage.pinLeft(to: wrap.leadingAnchor, Constants.HelpImage.leadingIndent)
    }
    
    private func configureHelpLabel() {
        wrap.addSubview(helpLabel)
        
        helpLabel.text = Constants.HelpLabel.text
        helpLabel.textColor = Constants.HelpLabel.textColor
        helpLabel.textAlignment = Constants.HelpLabel.textAlignment
        helpLabel.font = UIFont.systemFont(ofSize: Constants.HelpLabel.fontSize, weight: Constants.HelpLabel.fontWeight)
        
        helpLabel.pinCenterY(to: wrap.centerYAnchor)
        helpLabel.pinLeft(to: helpImage.trailingAnchor, Constants.HelpLabel.leadingIndent)
    }
}


