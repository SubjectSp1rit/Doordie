//
//  ShimmerHabitCell.swift
//  Doordie
//
//  Created by Arseniy on 24.03.2025.
//

import UIKit

final class ShimmerHabitCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum ShimmerWrap {
            static let height: CGFloat = 70
            static let cornerRadius: CGFloat = 14
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
            static let bottomIndent: CGFloat = 10
        }
        
        enum ShimmerCheckmarkButton {
            static let cornerRadius: CGFloat = 12
            static let height: CGFloat = 24
            static let width: CGFloat = 24
            static let leadingIndent: CGFloat = 12
        }
        
        enum ShimmerHabitImageWrap {
            static let height: CGFloat = 46
            static let width: CGFloat = 46
            static let cornerRadius: CGFloat = 14
            static let leadingIndent: CGFloat = 14
        }
        
        enum ShimmerHabitTitle {
            static let height: CGFloat = 18
            static let width: CGFloat = 150
            static let cornerRadius: CGFloat = 9
            static let leadingIndent: CGFloat = 8
        }
    }
    
    static let reuseId: String = "ShimmerHabitCell"
    
    // MARK: - UI Components
    private let shimmerWrap: ShimmerView = ShimmerView()
    private let shimmerCheckmarkButton: ShimmerView = ShimmerView()
    private let shimmerHabitImageWrap: ShimmerView = ShimmerView()
    private let shimmerHabitTitle: ShimmerView = ShimmerView()
    
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
        shimmerCheckmarkButton.startAnimating()
        shimmerHabitImageWrap.startAnimating()
        shimmerHabitTitle.startAnimating()
    }

    func stopShimmer() {
        shimmerWrap.stopAnimating()
        shimmerCheckmarkButton.stopAnimating()
        shimmerHabitImageWrap.stopAnimating()
        shimmerHabitTitle.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureShimmerCheckmarkButton()
        configureShimmerHabitImageWrap()
        configureShimmerHabitTitle()
    }
    
    private func configureWrap() {
        contentView.addSubview(shimmerWrap)
        
        shimmerWrap.layer.cornerRadius = Constants.ShimmerWrap.cornerRadius
        
        shimmerWrap.setHeight(Constants.ShimmerWrap.height)
        shimmerWrap.pinTop(to: contentView.topAnchor)
        shimmerWrap.pinBottom(to: contentView.bottomAnchor, Constants.ShimmerWrap.bottomIndent)
        shimmerWrap.pinLeft(to: contentView.leadingAnchor, Constants.ShimmerWrap.leadingIndent)
        shimmerWrap.pinRight(to: contentView.trailingAnchor, Constants.ShimmerWrap.trailingIndent)
    }
    
    private func configureShimmerCheckmarkButton() {
        shimmerWrap.addSubview(shimmerCheckmarkButton)
        
        shimmerCheckmarkButton.layer.cornerRadius = Constants.ShimmerCheckmarkButton.cornerRadius
        
        shimmerCheckmarkButton.setHeight(Constants.ShimmerCheckmarkButton.height)
        shimmerCheckmarkButton.setWidth(Constants.ShimmerCheckmarkButton.width)
        
        shimmerCheckmarkButton.pinCenterY(to: shimmerWrap.centerYAnchor)
        shimmerCheckmarkButton.pinLeft(to: shimmerWrap.leadingAnchor, Constants.ShimmerCheckmarkButton.leadingIndent)
    }
    
    private func configureShimmerHabitImageWrap() {
        shimmerWrap.addSubview(shimmerHabitImageWrap)
        
        shimmerHabitImageWrap.layer.cornerRadius = Constants.ShimmerHabitImageWrap.cornerRadius
        
        shimmerHabitImageWrap.setHeight(Constants.ShimmerHabitImageWrap.height)
        shimmerHabitImageWrap.setWidth(Constants.ShimmerHabitImageWrap.width)
        
        shimmerHabitImageWrap.pinCenterY(to: shimmerWrap.centerYAnchor)
        shimmerHabitImageWrap.pinLeft(to: shimmerCheckmarkButton.trailingAnchor, Constants.ShimmerHabitImageWrap.leadingIndent)
    }
    
    private func configureShimmerHabitTitle() {
        shimmerWrap.addSubview(shimmerHabitTitle)
        
        shimmerHabitTitle.layer.cornerRadius = Constants.ShimmerHabitTitle.cornerRadius
        
        shimmerHabitTitle.setHeight(Constants.ShimmerHabitTitle.height)
        shimmerHabitTitle.setWidth(Constants.ShimmerHabitTitle.width)
        
        shimmerHabitTitle.pinCenterY(to: shimmerWrap.centerYAnchor)
        shimmerHabitTitle.pinLeft(to: shimmerHabitImageWrap.trailingAnchor, Constants.ShimmerHabitTitle.leadingIndent)
    }
}

