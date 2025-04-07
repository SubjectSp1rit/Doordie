//
//  AnalyticsCollectionViewCell.swift
//  Doordie
//
//  Created by Arseniy on 07.04.2025.
//

import UIKit

final class AnalyticsCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Wrap {
            static let height: CGFloat = 200
            static let width: CGFloat = 36
        }
        
        enum RectangleView {
            static let width: CGFloat = 28
            static let height: CGFloat = 140
            static let bottomIndent: CGFloat = 14
        }
        
        enum QuantityLabel {
            static let bottomIndent: CGFloat = 8
        }
    }
    
    static let reuseId: String = "AnalyticsCollectionViewCell"
    
    // MARK: - UI Components
    private let wrap: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let rectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "5771DB").withAlphaComponent(0.7)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Properties
    private var rectangleHeightConstraint: NSLayoutConstraint!
    
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
    func configure(dayText: String, count: Int, height: CGFloat) {
        dayLabel.text = dayText
        quantityLabel.text = "\(count)"
        
        if height == 0 {
            rectangleHeightConstraint.constant = 10
        } else {
            rectangleHeightConstraint.constant = height
        }
        layoutIfNeeded()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        contentView.addSubview(wrap)
        wrap.addSubview(dayLabel)
        wrap.addSubview(rectangleView)
        wrap.addSubview(quantityLabel)
    }
    
    private func configureConstraints() {
        wrap.pin(to: contentView)
        wrap.setHeight(Constants.Wrap.height)
        wrap.setWidth(Constants.Wrap.width)
        
        dayLabel.pinBottom(to: wrap.bottomAnchor)
        dayLabel.pinCenterX(to: wrap.centerXAnchor)
        
        rectangleView.pinBottom(to: dayLabel.topAnchor, Constants.RectangleView.bottomIndent)
        rectangleView.pinCenterX(to: wrap.centerXAnchor)
        rectangleHeightConstraint = rectangleView.setHeight(Constants.RectangleView.height)
        rectangleView.setWidth(Constants.RectangleView.width)
        
        quantityLabel.pinBottom(to: rectangleView.topAnchor, Constants.QuantityLabel.bottomIndent)
        quantityLabel.pinCenterX(to: rectangleView.centerXAnchor)
    }
}
