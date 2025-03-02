//
//  LoginViewController.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Log in"
        }
        
        enum EmailLabel {
            static let text: String = "Email"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum EmailTextField {
            static let bgColor: UIColor = .white
            static let cornerRadius: CGFloat = 14
            static let textColor: UIColor = .black
            static let fontSize: CGFloat = 22
            static let keyboardType: UIKeyboardType = .emailAddress
            static let autocorrectionType: UITextAutocorrectionType = .no
            static let autocapitalizationType: UITextAutocapitalizationType = .none
            static let placeholder: String = "example@doordie.app"
            static let clearButtonMode: UITextField.ViewMode = .whileEditing
            static let paddingRight: CGFloat = 10
            static let clearButtonColor: UIColor = .systemGray
            static let textAlignment: NSTextAlignment = .left
            static let leftTextPadding: CGFloat = 8
            static let minimumBorderWidth: CGFloat = 0
            static let maximumBorderWidth: CGFloat = 2
            static let borderColor: CGColor = UIColor.systemRed.cgColor
            static let height: CGFloat = 50
            static let topIndent: CGFloat = 4
            static let leadingIndent: CGFloat = 18
        }
        
        enum PasswordLabel {
            static let text: String = "Password"
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 18
        }
        
        enum PasswordTextField {
            static let bgColor: UIColor = .white
            static let cornerRadius: CGFloat = 14
            static let textColor: UIColor = .black
            static let fontSize: CGFloat = 22
            static let keyboardType: UIKeyboardType = .default
            static let placeholder: String = "••••••••"
            static let autocorrectionType: UITextAutocorrectionType = .no
            static let autocapitalizationType: UITextAutocapitalizationType = .none
            static let secureButtonMode: UITextField.ViewMode = .whileEditing
            static let secureButtonColor: UIColor = .systemGray
            static let paddingRightView: CGFloat = 10
            static let textAlignment: NSTextAlignment = .left
            static let paddingLeft: CGFloat = 8
            static let minimumBorderWidth: CGFloat = 0
            static let maximumBorderWidth: CGFloat = 2
            static let borderColor: CGColor = UIColor.systemRed.cgColor
            static let isSecureText: Bool = true
            static let height: CGFloat = 50
            static let topIndent: CGFloat = 4
            static let leadingIndent: CGFloat = 18
        }
        
        enum LoginButton {
            static let bgColor: UIColor = UIColor(hex: "3A50C2")
            static let title: String = "Log in"
            static let tintColor: UIColor = .white
            static let height: CGFloat = 50
            static let cornerRadius: CGFloat = 14
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 18
        }
        
        enum RestorePasswordButton {
            static let bgColor: UIColor = .clear
            static let title: String = "Forgot password?"
            static let tintColor: UIColor = .white
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum RegisterButton {
            static let bgColor: UIColor = .clear
            static let title: String = "Don't have an account?"
            static let tintColor: UIColor = .white
            static let trailingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
    }
    
    // MARK: - UI Components
    let background: UIImageView = UIImageView()
    let emailLabel: UILabel = UILabel()
    let emailTextField: UITextField = UITextField()
    let passwordLabel: UILabel = UILabel()
    let passwordTextField: UIPasswordTextField = UIPasswordTextField()
    let loginButton: UIButton = UIButton(type: .system)
    let restorePasswordButton: UIButton = UIButton(type: .system)
    let registerButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    private var interactor: LoginBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: LoginBusinessLogic) {
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
        configureEmailLabel()
        configureEmailTextField()
        configurePasswordLabel()
        configurePasswordTextField()
        configureLoginButton()
        configureRestorePasswordButton()
        configureRegisterButton()
        
        configureDismissKeyboardTap()
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
        navigationItem.title = Constants.NavBar.title
    }
    
    private func configureEmailLabel() {
        view.addSubview(emailLabel)
        
        emailLabel.text = Constants.EmailLabel.text
        emailLabel.textColor = Constants.EmailLabel.textColor
        emailLabel.textAlignment = Constants.EmailLabel.textAlignment
        emailLabel.numberOfLines = Constants.EmailLabel.numberOfLines
        
        emailLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        emailLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EmailLabel.leadingIndent)
        emailLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.EmailLabel.topIndent)
    }
    
    private func configureEmailTextField() {
        view.addSubview(emailTextField)
        
        emailTextField.backgroundColor = Constants.EmailTextField.bgColor
        emailTextField.layer.cornerRadius = Constants.EmailTextField.cornerRadius
        emailTextField.textColor = Constants.EmailTextField.textColor
        emailTextField.font = UIFont.systemFont(ofSize: Constants.EmailTextField.fontSize)
        emailTextField.keyboardType = Constants.EmailTextField.keyboardType
        emailTextField.autocorrectionType = Constants.EmailTextField.autocorrectionType
        emailTextField.autocapitalizationType = Constants.EmailTextField.autocapitalizationType
        emailTextField.attributedPlaceholder =
        NSAttributedString(string: Constants.EmailTextField.placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        emailTextField.setCustomClearButton(mode: Constants.EmailTextField.clearButtonMode, color: Constants.EmailTextField.clearButtonColor, padding: Constants.EmailTextField.paddingRight)
        emailTextField.textAlignment = Constants.EmailTextField.textAlignment
        emailTextField.setLeftPadding(left: Constants.EmailTextField.leftTextPadding)
        
        emailTextField.setHeight(Constants.EmailTextField.height)
        emailTextField.pinTop(to: emailLabel.bottomAnchor, Constants.EmailTextField.topIndent)
        emailTextField.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        emailTextField.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EmailTextField.leadingIndent)
    }
    
    private func configurePasswordLabel() {
        view.addSubview(passwordLabel)
        
        passwordLabel.text = Constants.PasswordLabel.text
        passwordLabel.textColor = Constants.PasswordLabel.textColor
        passwordLabel.textAlignment = Constants.PasswordLabel.textAlignment
        passwordLabel.numberOfLines = Constants.PasswordLabel.numberOfLines
        
        passwordLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        passwordLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.PasswordLabel.leadingIndent)
        passwordLabel.pinTop(to: emailTextField.bottomAnchor, Constants.PasswordLabel.topIndent)
    }
    
    private func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.backgroundColor = Constants.PasswordTextField.bgColor
        passwordTextField.layer.cornerRadius = Constants.PasswordTextField.cornerRadius
        passwordTextField.textColor = Constants.PasswordTextField.textColor
        passwordTextField.font = UIFont.systemFont(ofSize: Constants.PasswordTextField.fontSize)
        passwordTextField.keyboardType = Constants.PasswordTextField.keyboardType
        passwordTextField.autocorrectionType = Constants.PasswordTextField.autocorrectionType
        passwordTextField.autocapitalizationType = Constants.PasswordTextField.autocapitalizationType
        passwordTextField.attributedPlaceholder =
        NSAttributedString(string: Constants.PasswordTextField.placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        passwordTextField.setCustomVisibilityButton(mode: Constants.PasswordTextField.secureButtonMode, color: Constants.PasswordTextField.secureButtonColor, padding: Constants.PasswordTextField.paddingRightView)
        passwordTextField.isSecureTextEntry = Constants.PasswordTextField.isSecureText
        passwordTextField.textAlignment = Constants.PasswordTextField.textAlignment
        passwordTextField.setLeftPadding(left: Constants.PasswordTextField.paddingLeft)
        
        passwordTextField.setHeight(Constants.PasswordTextField.height)
        passwordTextField.pinTop(to: passwordLabel.bottomAnchor, Constants.PasswordTextField.topIndent)
        passwordTextField.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        passwordTextField.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.PasswordTextField.leadingIndent)
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.backgroundColor = Constants.LoginButton.bgColor
        loginButton.tintColor = Constants.LoginButton.tintColor
        loginButton.setTitle(Constants.LoginButton.title, for: .normal)
        loginButton.layer.cornerRadius = Constants.LoginButton.cornerRadius
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        loginButton.setHeight(Constants.LoginButton.height)
        loginButton.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        loginButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.LoginButton.leadingIndent)
        loginButton.pinTop(to: passwordTextField.bottomAnchor, Constants.LoginButton.topIndent)
    }
    
    private func configureRestorePasswordButton() {
        view.addSubview(restorePasswordButton)
        
        restorePasswordButton.backgroundColor = Constants.RestorePasswordButton.bgColor
        restorePasswordButton.setTitle(Constants.RestorePasswordButton.title, for: .normal)
        restorePasswordButton.tintColor = Constants.RestorePasswordButton.tintColor
        restorePasswordButton.addTarget(self, action: #selector(restorePasswordButtonPressed), for: .touchUpInside)
        
        restorePasswordButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.RestorePasswordButton.leadingIndent)
        restorePasswordButton.pinTop(to: loginButton.bottomAnchor, Constants.RestorePasswordButton.topIndent)
    }
    
    private func configureRegisterButton() {
        view.addSubview(registerButton)
        
        registerButton.backgroundColor = Constants.RegisterButton.bgColor
        registerButton.setTitle(Constants.RegisterButton.title, for: .normal)
        registerButton.tintColor = Constants.RegisterButton.tintColor
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        registerButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, Constants.RegisterButton.trailingIndent)
        registerButton.pinTop(to: loginButton.bottomAnchor, Constants.RegisterButton.topIndent)
    }
    
    private func configureDismissKeyboardTap() {
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginButtonPressed() {
        // login logic
    }
    
    @objc private func restorePasswordButtonPressed() {
        interactor.showRestorePasswordScreen(LoginModels.RouteToRestorePasswordScreen.Request())
    }
    
    @objc private func registerButtonPressed() {
        // register logic
    }
}
