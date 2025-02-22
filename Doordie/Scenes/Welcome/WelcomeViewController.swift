//
//  WelcomeViewController.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

final class WelcomeViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum LogoImage {
            static let imageName: String = "appIconImage"
            static let height: CGFloat = 150
            static let width: CGFloat = 150
            static let cornerRadius: CGFloat = 20
            static let contentMode: UIView.ContentMode = .scaleAspectFit
        }
        
        enum DoordieTitle {
            static let title: String = "Doordie"
            static let alignment: NSTextAlignment = .center
            static let color: UIColor = .white
            static let fontSize: CGFloat = 40
            static let fontWeight: UIFont.Weight = .regular
            static let topIndent: CGFloat = 18
        }
        
        enum LoginButton {
            static let title: String = "Log in"
            static let titleColor: UIColor = .white
            static let bgColor: UIColor = UIColor(hex: "3A50C2")
            static let cornerRadius: CGFloat = 25
            static let height: CGFloat = 50
            static let width: CGFloat = 350
            static let bottomIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 18
        }
        
        enum SignupButton {
            static let title: String = "Sign up"
            static let titleColor: UIColor = .white
            static let bgColor: UIColor = .clear
            static let height: CGFloat = 50
            static let bottomIndent: CGFloat = 18
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let logoImage: UIImageView = UIImageView()
    private let doordieTitle: UILabel = UILabel()
    private let loginButton: UIButton = UIButton(type: .system)
    private let signupButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    private var interactor: WelcomeBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: WelcomeBusinessLogic) {
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
        configureLogoImage()
        configureDoordieTitle()
        configureSignupButton()
        configureLoginButton()
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
    
    private func configureLogoImage() {
        view.addSubview(logoImage)
        
        logoImage.image = UIImage(named: Constants.LogoImage.imageName)
        logoImage.layer.cornerRadius = Constants.LogoImage.cornerRadius
        logoImage.contentMode = Constants.LogoImage.contentMode
        
        logoImage.pinCenter(to: view)
        logoImage.setHeight(Constants.LogoImage.height)
        logoImage.setWidth(Constants.LogoImage.width)
    }
    
    private func configureDoordieTitle() {
        view.addSubview(doordieTitle)
        
        doordieTitle.text = Constants.DoordieTitle.title
        doordieTitle.textAlignment = Constants.DoordieTitle.alignment
        doordieTitle.font = UIFont.systemFont(ofSize: Constants.DoordieTitle.fontSize, weight: Constants.DoordieTitle.fontWeight)
        doordieTitle.textColor = Constants.DoordieTitle.color
        
        doordieTitle.pinTop(to: logoImage.bottomAnchor, Constants.DoordieTitle.topIndent)
        doordieTitle.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
    }
    
    private func configureSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.setTitle(Constants.SignupButton.title, for: .normal)
        signupButton.tintColor = Constants.SignupButton.titleColor
        signupButton.backgroundColor = Constants.SignupButton.bgColor
        
        signupButton.setHeight(Constants.SignupButton.height)
        signupButton.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        signupButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.SignupButton.bottomIndent)
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.setTitle(Constants.LoginButton.title, for: .normal)
        loginButton.tintColor = Constants.LoginButton.titleColor
        loginButton.backgroundColor = Constants.LoginButton.bgColor
        loginButton.layer.cornerRadius = Constants.LoginButton.cornerRadius
        
        loginButton.setHeight(Constants.LoginButton.height)
        loginButton.setWidth(Constants.LoginButton.width)
        loginButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.LoginButton.leadingIndent, .grOE)
        loginButton.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        loginButton.pinBottom(to: signupButton.topAnchor, Constants.LoginButton.bottomIndent)
    }
}
