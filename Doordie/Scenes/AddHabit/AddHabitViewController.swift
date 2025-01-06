//
//  AddHabitViewController.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class AddHabitViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBarCenteredTitle {
            static let title: String = "Create habit"
            static let alignment: NSTextAlignment = .center
            static let color: UIColor = .white
            static let fontSize: CGFloat = 18
            static let fontWeight: UIFont.Weight = .semibold
        }
        
        enum NavBarDismissButton {
            static let tintColor: UIColor = .white
            static let imageName: String = "chevron.down"
            static let imageWeight: UIImage.SymbolWeight = .medium
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let navBarCenteredTitle: UILabel = UILabel()
    private let navBarDismissButton: UIButton = UIButton(type: .system)
    
    // MARK: - Variables
    private var interactor: AddHabitBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: AddHabitBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureNavBarDismissButton()
    }
    
    private func configureBackground() {
        view.addSubview(background)
        
        background.image = UIImage(named: Constants.Background.imageName)
        background.pin(to: view)
                
        // Размытие заднего фона
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        
        blurEffectView.pin(to: view)
    }
    
    private func configureNavBar() {
        navBarCenteredTitle.text = Constants.NavBarCenteredTitle.title
        navBarCenteredTitle.textAlignment = Constants.NavBarCenteredTitle.alignment
        navBarCenteredTitle.font = UIFont.systemFont(ofSize: Constants.NavBarCenteredTitle.fontSize, weight: Constants.NavBarCenteredTitle.fontWeight)
        navBarCenteredTitle.textColor = Constants.NavBarCenteredTitle.color
        
        navigationItem.titleView = navBarCenteredTitle
    }
    
    private func configureNavBarDismissButton() {
        let dismissButtonImageConfiguration = UIImage.SymbolConfiguration(weight: Constants.NavBarDismissButton.imageWeight)
        navBarDismissButton.setImage(UIImage(systemName: Constants.NavBarDismissButton.imageName, withConfiguration: dismissButtonImageConfiguration), for: .normal)
        navBarDismissButton.tintColor = Constants.NavBarDismissButton.tintColor
        navBarDismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: navBarDismissButton)
        navigationItem.leftBarButtonItem = barButton
    }
    
    // MARK: - Actions
    @objc
    private func dismissButtonPressed() {
        dismiss(animated: true)
    }
}
