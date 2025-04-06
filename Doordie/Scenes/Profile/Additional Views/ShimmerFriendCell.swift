//
//  ShimmerFriendCell.swift
//  Doordie
//
//  Created by Arseniy on 05.04.2025.
//

import UIKit

final class ShimmerFriendCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum ShimmerWrap {
            static let height: CGFloat = 100
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
        
        enum ShimmerProfileImage {
            static let cornerRadius: CGFloat = 35
            static let imageSide: CGFloat = 70
            static let leadingIndent: CGFloat = 14
        }
        
        enum ShimmerNameLabel {
            static let height: CGFloat = 18
            static let width: CGFloat = 150
            static let cornerRadius: CGFloat = 9
            static let leadingIndent: CGFloat = 8
        }
    }
    
    static let reuseId: String = "ShimmerFriendCell"
    
    // MARK: - UI Components
    private let shimmerWrap: ShimmerView = ShimmerView()
    private let shimmerProfileImage: ShimmerView = ShimmerView()
    private let shimmerNameLabel: ShimmerView = ShimmerView()
    
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
    func startShimmer() {
        shimmerWrap.startAnimating()
        shimmerProfileImage.startAnimating()
        shimmerNameLabel.startAnimating()
    }

    func stopShimmer() {
        shimmerWrap.stopAnimating()
        shimmerProfileImage.stopAnimating()
        shimmerNameLabel.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureShimmerWrap()
        configureShimmerProfileImage()
        configureShimmerNameLabel()
    }
    
    private func configureShimmerWrap() {
        contentView.addSubview(shimmerWrap)
        
        shimmerWrap.layer.cornerRadius = Constants.ShimmerWrap.cornerRadius
        
        // Тень
        shimmerWrap.layer.shadowColor = Constants.ShimmerWrap.shadowColor
        shimmerWrap.layer.shadowOpacity = Constants.ShimmerWrap.shadowOpacity
        shimmerWrap.layer.shadowOffset = CGSize(width: Constants.ShimmerWrap.shadowOffsetX, height: Constants.ShimmerWrap.shadowOffsetY)
        shimmerWrap.layer.shadowRadius = Constants.ShimmerWrap.shadowRadius
        shimmerWrap.layer.masksToBounds = false
        
        shimmerWrap.setHeight(Constants.ShimmerWrap.height)
        shimmerWrap.pinTop(to: contentView.topAnchor)
        shimmerWrap.pinBottom(to: contentView.bottomAnchor, Constants.ShimmerWrap.bottomIndent)
        shimmerWrap.pinLeft(to: contentView.leadingAnchor, Constants.ShimmerWrap.leadingIndent)
        shimmerWrap.pinRight(to: contentView.trailingAnchor, Constants.ShimmerWrap.trailingIndent)
    }
    
    private func configureShimmerProfileImage() {
        shimmerWrap.addSubview(shimmerProfileImage)
        
        shimmerProfileImage.layer.cornerRadius = Constants.ShimmerProfileImage.cornerRadius
        shimmerProfileImage.clipsToBounds = true
        
        shimmerProfileImage.pinLeft(to: shimmerWrap.leadingAnchor, Constants.ShimmerProfileImage.leadingIndent)
        shimmerProfileImage.pinCenterY(to: shimmerWrap.centerYAnchor)
        shimmerProfileImage.setWidth(Constants.ShimmerProfileImage.imageSide)
        shimmerProfileImage.setHeight(Constants.ShimmerProfileImage.imageSide)
    }
    
    private func configureShimmerNameLabel() {
        shimmerWrap.addSubview(shimmerNameLabel)
        
        shimmerNameLabel.layer.cornerRadius = Constants.ShimmerNameLabel.cornerRadius
        
        shimmerNameLabel.setHeight(Constants.ShimmerNameLabel.height)
        shimmerNameLabel.setWidth(Constants.ShimmerNameLabel.width)
        
        shimmerNameLabel.pinCenterY(to: shimmerWrap.centerYAnchor)
        shimmerNameLabel.pinLeft(to: shimmerProfileImage.trailingAnchor, Constants.ShimmerNameLabel.leadingIndent)
    }
}
