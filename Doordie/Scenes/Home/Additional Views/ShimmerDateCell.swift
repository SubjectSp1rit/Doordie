//
//  ShimmerDateCell.swift
//  Doordie
//
//  Created by Arseniy on 02.04.2025.
//

import UIKit

final class ShimmerDateCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum ShimmerWrap {
            static let cornerRadius: CGFloat = 20
            static let height: CGFloat = 100
            static let width: CGFloat = 80
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
    }
    
    static let reuseId: String = "ShimmerDateCell"
    
    // MARK: - UI Components
    private let shimmerWrap: ShimmerView = ShimmerView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func startShimmer() {
        shimmerWrap.startAnimating()
    }

    func stopShimmer() {
        shimmerWrap.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureShimmerWrap()
    }
    
    private func configureShimmerWrap() {
        contentView.addSubview(shimmerWrap)
        
        shimmerWrap.layer.cornerRadius = Constants.ShimmerWrap.cornerRadius
        shimmerWrap.setWidth(Constants.ShimmerWrap.width)
        shimmerWrap.setHeight(Constants.ShimmerWrap.height)
        
        // Тень
        shimmerWrap.layer.shadowColor = Constants.ShimmerWrap.shadowColor
        shimmerWrap.layer.shadowOpacity = Constants.ShimmerWrap.shadowOpacity
        shimmerWrap.layer.shadowOffset = CGSize(width: Constants.ShimmerWrap.shadowOffsetX, height: Constants.ShimmerWrap.shadowOffsetY)
        shimmerWrap.layer.shadowRadius = Constants.ShimmerWrap.shadowRadius
        shimmerWrap.layer.masksToBounds = false
        
        shimmerWrap.pinLeft(to: contentView.leadingAnchor)
        shimmerWrap.pinRight(to: contentView.trailingAnchor)
        shimmerWrap.pinBottom(to: contentView.bottomAnchor)
        shimmerWrap.pinTop(to: contentView.topAnchor)
    }
}
