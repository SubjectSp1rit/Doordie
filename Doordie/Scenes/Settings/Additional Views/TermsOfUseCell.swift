//
//  TermsOfUseCell.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//

import UIKit

final class TermsOfUseCell: UITableViewCell {
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
        
        enum TermsOfUseImage {
            static let imageName: String = "text.document"
            static let tintColor: UIColor = .white
            static let imageSide: CGFloat = 24
            static let leadingIndent: CGFloat = 18
        }
        
        enum TermsOfUseLabel {
            static let text: String = "Terms of use"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontWeight: UIFont.Weight = .medium
            static let fontSize: CGFloat = 18
            static let leadingIndent: CGFloat = 12
        }
    }
    
    static let reuseId: String = "TermsOfUseCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let chevron: UIImageView = UIImageView()
    private let termsOfUseImage: UIImageView = UIImageView()
    private let termsOfUseLabel: UILabel = UILabel()
    
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
        configureTermsOfUseImage()
        configureTermsOfUseLabel()
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
    
    private func configureTermsOfUseImage() {
        wrap.addSubview(termsOfUseImage)
        
        termsOfUseImage.image = UIImage(systemName: Constants.TermsOfUseImage.imageName)
        termsOfUseImage.tintColor = Constants.TermsOfUseImage.tintColor
        termsOfUseImage.clipsToBounds = true
        termsOfUseImage.setWidth(Constants.TermsOfUseImage.imageSide)
        termsOfUseImage.setHeight(Constants.TermsOfUseImage.imageSide)
        
        termsOfUseImage.pinCenterY(to: wrap.centerYAnchor)
        termsOfUseImage.pinLeft(to: wrap.leadingAnchor, Constants.TermsOfUseImage.leadingIndent)
    }
    
    private func configureTermsOfUseLabel() {
        wrap.addSubview(termsOfUseLabel)
        
        termsOfUseLabel.text = Constants.TermsOfUseLabel.text
        termsOfUseLabel.textColor = Constants.TermsOfUseLabel.textColor
        termsOfUseLabel.textAlignment = Constants.TermsOfUseLabel.textAlignment
        termsOfUseLabel.font = UIFont.systemFont(ofSize: Constants.TermsOfUseLabel.fontSize, weight: Constants.TermsOfUseLabel.fontWeight)
        
        termsOfUseLabel.pinCenterY(to: wrap.centerYAnchor)
        termsOfUseLabel.pinLeft(to: termsOfUseImage.trailingAnchor, Constants.TermsOfUseLabel.leadingIndent)
    }
}


