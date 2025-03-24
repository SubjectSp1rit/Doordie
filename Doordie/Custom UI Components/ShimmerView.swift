//
//  ShimmerView.swift
//  Doordie
//
//  Created by Arseniy on 24.03.2025.
//

import UIKit

class ShimmerView: UIView {
    // MARK: - Constants
    private enum Constants {
        // colors
        static let gradientColorOne:  CGColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6).cgColor
        static let gradientColorTwo: CGColor = UIColor(hex: "242765").withAlphaComponent(0.3).cgColor
        static let gradientColorThree: CGColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6).cgColor
        
        static let startValueOne: Double = 0.0
        static let startValueTwo: Double = 0.0
        static let startValueThree: Double = 0.25
        
        static let endValueOne: Double = 0.75
        static let endValueTwo: Double = 1.0
        static let endValueThree: Double = 1.0
        
        // keys
        static let CABasicsAnumationKeyPath: String = "locations"
        static let mainGradientLayerKey: String = "shimmerEffect"
        
        // animations
        static let shimmerAnimation: CFTimeInterval = 1
        static let shimmerAnimationsQuantity: Float = .infinity
        
        // coordinates
        static let startX: Double = -4.0
        static let startY: Double = -1.0
        
        static let endX: Double = 2.0
        static let endY: Double = 2.0
        
        static let gradienColorOneLocation: NSNumber = 0.0
        static let gradienColorTwoLocation: NSNumber = 0.5
        static let gradienColorThreeLocation: NSNumber = 1.0
    }
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupGradientLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func startAnimating() {
        let animation = CABasicAnimation(keyPath: Constants.CABasicsAnumationKeyPath)
        animation.fromValue = [Constants.startValueOne, Constants.startValueTwo, Constants.startValueThree]
        animation.toValue = [Constants.endValueOne, Constants.endValueTwo, Constants.endValueThree]
        animation.duration = Constants.shimmerAnimation
        animation.repeatCount = Constants.shimmerAnimationsQuantity
        gradientLayer.add(animation, forKey: Constants.mainGradientLayerKey)
    }

    func stopAnimating() {
        gradientLayer.removeAllAnimations()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
    }
    
    // MARK: - Private Methods
    private func setupGradientLayer() {
        gradientLayer.startPoint = CGPoint(x: Constants.startX, y: Constants.startY)
        gradientLayer.endPoint = CGPoint(x: Constants.endX, y: Constants.endY)

        gradientLayer.colors = [
            Constants.gradientColorOne,
            Constants.gradientColorTwo,
            Constants.gradientColorThree
        ]
        gradientLayer.locations = [Constants.gradienColorOneLocation, Constants.gradienColorTwoLocation, Constants.gradienColorThreeLocation]
        layer.addSublayer(gradientLayer)
    }
}
