//
//  CustomTabBar.swift
//  Doordie
//
//  Created by Arseniy on 28.12.2024.
//

import Foundation
import UIKit

final class CustomTabBar: UITabBar {
    // MARK: - Constants
    private enum Constants {
        // plusButton
        static let plusButtonSide: CGFloat = 60
        static let plusButtonCornerRadius: CGFloat = 30
        static let plusButtonBgColorHexCode: String = "242765"
        static let plusButtonBgColor: UIColor = UIColor(hex: plusButtonBgColorHexCode)
        static let plusButtonImageName: String = "plus"
        static let plusButtonTintColor: UIColor = .white
        
        // tabBar
        static let tabBarBgColorHexCode: String = "4C60C2"
        static let tabBarBgColor: UIColor = UIColor(hex: tabBarBgColorHexCode)
        static let tabBarTintColor: UIColor = .white
        static let tabBarUnselectedTintColor: UIColor = .white.withAlphaComponent(0.3)
    }
    
    // MARK: - UI Components
    private let plusButton: UIButton = UIButton(type: .custom)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureTabBarAppearance()
        configurePlusButton()
    }
    
    private func configureTabBarAppearance() {
        self.isTranslucent = false
        self.unselectedItemTintColor = Constants.tabBarUnselectedTintColor
        self.tintColor = Constants.tabBarTintColor
        self.backgroundColor = Constants.tabBarBgColor
    }

    private func configurePlusButton() {
        addSubview(plusButton)
        
        plusButton.frame.size = CGSize(width: Constants.plusButtonSide, height: Constants.plusButtonSide)
        plusButton.layer.cornerRadius = Constants.plusButtonCornerRadius
        plusButton.backgroundColor = Constants.plusButtonBgColor
        let plusButtonImage = UIImage(systemName: Constants.plusButtonImageName)
        plusButton.setImage(plusButtonImage, for: .normal)
        plusButton.tintColor = Constants.plusButtonTintColor
        plusButton.clipsToBounds = true
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func plusButtonTapped() {
        print("ADD HABIT HANDLER")
    }
    
    // MARK: - Overrided
    /// Вызывается при любом изменении размеров таббара
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let centerX = bounds.width / 2
        
        plusButton.center = CGPoint(x: centerX, y: 0)
    }
    
    /// Делает так, чтобы касания по кнопке обрабатывались даже
    /// если нажимаем "выше" или "ниже" обычного прямоугольника таббара
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let convertedPoint = plusButton.convert(point, from: self)
        
        // Если точка попала в круг, возвращаем plusButton
        if plusButton.bounds.contains(convertedPoint) {
            return plusButton
        }
        
        // Иначе — стандартная обработка
        return super.hitTest(point, with: event)
    }
}
