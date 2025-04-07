//
//  ShimmerDateCollectionViewCell.swift
//  Doordie
//
//  Created by Arseniy on 07.04.2025.
//

import UIKit

final class ShimmerDateCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum ShimmerWrap {
            static let height: CGFloat = 60
            static let width: CGFloat = 36
        }
        
        enum ShimmerDayLabel {
            static let height: CGFloat = 10
            static let width: CGFloat = 24
            static let cornerRadius: CGFloat = 5
        }
        
        enum ShimmerSquareView {
            static let side: CGFloat = 36
            static let cornerRadius: CGFloat = 14
            static let topIndent: CGFloat = 8
        }
    }
    
    static let reuseId: String = "ShimmerDateCollectionViewCell"
    
    // MARK: - UI Components
    private let shimmerWrap: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let shimmerDayLabel: ShimmerView = {
        let view = ShimmerView()
        view.layer.cornerRadius = Constants.ShimmerDayLabel.cornerRadius
        return view
    }()
    
    private let shimmerSquareView: ShimmerView = {
        let view = ShimmerView()
        view.layer.cornerRadius = Constants.ShimmerSquareView.cornerRadius
        return view
    }()
    
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
        shimmerDayLabel.startAnimating()
        shimmerSquareView.startAnimating()
    }

    func stopShimmer() {
        shimmerDayLabel.stopAnimating()
        shimmerSquareView.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        contentView.addSubview(shimmerWrap)
        shimmerWrap.addSubview(shimmerDayLabel)
        shimmerWrap.addSubview(shimmerSquareView)
    }
    
    private func configureConstraints() {
        shimmerWrap.pin(to: contentView)
        shimmerWrap.setHeight(Constants.ShimmerWrap.height)
        shimmerWrap.setWidth(Constants.ShimmerWrap.width)
        
        shimmerDayLabel.setHeight(Constants.ShimmerDayLabel.height)
        shimmerDayLabel.setWidth(Constants.ShimmerDayLabel.width)
        shimmerDayLabel.pinTop(to: shimmerWrap.topAnchor)
        shimmerDayLabel.pinCenterX(to: shimmerWrap.centerXAnchor)
        
        shimmerSquareView.setHeight(Constants.ShimmerSquareView.side)
        shimmerSquareView.setWidth(Constants.ShimmerSquareView.side)
        shimmerSquareView.pinTop(to: shimmerDayLabel.bottomAnchor, Constants.ShimmerSquareView.topIndent)
        shimmerSquareView.pinCenterX(to: shimmerWrap.centerXAnchor)
    }
}
