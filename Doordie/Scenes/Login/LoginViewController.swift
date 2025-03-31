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
            static let tintColor: UIColor = .white
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
            static let borderWidth: CGFloat = 2
            static let standardBorderColor: CGColor = UIColor.clear.cgColor
            static let errorBorderColor: CGColor = UIColor.systemRed.cgColor
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
            static let borderWidth: CGFloat = 2
            static let standardBorderColor: CGColor = UIColor.clear.cgColor
            static let errorBorderColor: CGColor = UIColor.systemRed.cgColor
            static let isSecureText: Bool = true
            static let height: CGFloat = 50
            static let topIndent: CGFloat = 4
            static let leadingIndent: CGFloat = 18
        }
        
        enum EmailNotExistsLabel {
            static let textPrimary: String = "Account doesn't exists:  "
            static let textSecondary: String = "Register"
            static let textColorPrimary: UIColor = .systemRed
            static let textColorSecondary: UIColor = .white
            static let font: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
            static let textAlignment: NSTextAlignment = .left
            static let transparencyMin: CGFloat = 0
            static let transparencyMax: CGFloat = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum WrongPasswordLabel {
            static let textPrimary: String = "Wrong password: "
            static let textSecondary: String = "Recover account"
            static let textColorPrimary: UIColor = .systemRed
            static let textColorSecondary: UIColor = .white
            static let font: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
            static let textAlignment: NSTextAlignment = .left
            static let transparencyMin: CGFloat = 0
            static let transparencyMax: CGFloat = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum LoginButton {
            static let bgColor: UIColor = UIColor(hex: "3A50C2")
            static let title: String = "Log in"
            static let tintColor: UIColor = .white
            static let height: CGFloat = 50
            static let transparencyMin: CGFloat = 0.5
            static let transparencyMax: CGFloat = 1
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
        
        enum AuthOverlay {
            enum Overlay {
                static let bgColor: UIColor = .clear
            }
            
            enum BlurEffectView {
                static let style: UIBlurEffect.Style = .dark
            }
            
            enum ActivityIndicator {
                static let style: UIActivityIndicatorView.Style = .large
                static let color: UIColor = .white
                static let YCenterIndent: CGFloat = -20
            }
            
            enum AuthLabel {
                static let text: String = "Authorization..."
                static let fontSize: CGFloat = 14
                static let textColor: UIColor = .white
                static let topIndent: CGFloat = 8
            }
        }
    }
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let emailLabel: UILabel = UILabel()
    private let emailTextField: UITextField = UITextField()
    private let passwordLabel: UILabel = UILabel()
    private let passwordTextField: UIPasswordTextField = UIPasswordTextField()
    private let emailNotExistsLabel: UILabel = UILabel()
    private let wrongPasswordLabel: UILabel = UILabel()
    private let loginButton: UIButton = UIButton(type: .system)
    private let restorePasswordButton: UIButton = UIButton(type: .system)
    private let registerButton: UIButton = UIButton(type: .system)
    private var authOverlay: UIView?
    
    // MARK: - Properties
    private var interactor: LoginBusinessLogic
    private var emailNotExistsLabelConstraint: NSLayoutConstraint?
    private var wrongPasswordLabelConstraint: NSLayoutConstraint?
    private var email: String?
    
    // MARK: - Lifecycle
    init(interactor: LoginBusinessLogic, email: String?) {
        self.email = email
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
    
    // MARK: - Methods
    func displayIfEmailExists(_ viewModel: LoginModels.CheckEmailExists.ViewModel) {
        if viewModel.isExists {
            // Если почта существует в базе данных - отправляем запрос на вход
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            interactor.loginUser(LoginModels.LoginUser.Request(email: email, password: password))
        } else {
            emailNotExistsLabelConstraint?.isActive = false
            emailNotExistsLabelConstraint = emailNotExistsLabel.pinTop(to: passwordTextField.bottomAnchor, Constants.EmailNotExistsLabel.topIndent)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.emailTextField.layer.borderColor = Constants.EmailTextField.errorBorderColor
                self.emailNotExistsLabel.alpha = Constants.EmailNotExistsLabel.transparencyMax
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func displayAfterLogin(_ viewModel: LoginModels.LoginUser.viewModel) {
        let isLoginSuccess = viewModel.isSuccess
        switch isLoginSuccess {
            
        case true:
            // переводим юзера на главный экран
            showAuthorizationOverlay()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.interactor.routeToHomeScreen(LoginModels.RouteToHomeScreen.Request())
            }
        case false:
            // Показываем ошибку неправильного пароля
            wrongPasswordLabelConstraint?.isActive = false
            wrongPasswordLabelConstraint = wrongPasswordLabel.pinTop(to: passwordTextField.bottomAnchor, Constants.WrongPasswordLabel.topIndent)
            emailNotExistsLabelConstraint?.isActive = false // Двигаем сообщение об ошибке почты тоже, но не показываем (альфа = 0)
            emailNotExistsLabelConstraint = emailNotExistsLabel.pinTop(to: passwordTextField.bottomAnchor, Constants.EmailNotExistsLabel.topIndent)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.passwordTextField.layer.borderColor = Constants.PasswordTextField.errorBorderColor
                self.wrongPasswordLabel.alpha = Constants.WrongPasswordLabel.transparencyMax
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureEmailLabel()
        configureEmailTextField()
        configurePasswordLabel()
        configurePasswordTextField()
        configureEmailNotExistsLabel()
        configureWrongPasswordLabel()
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
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.NavBar.tintColor]
    }
    
    private func showAuthorizationOverlay() {
        navigationController?.setNavigationBarHidden(true, animated: true) // Скрываем навигейшн бар
        
        let overlay = UIView()
        overlay.backgroundColor = Constants.AuthOverlay.Overlay.bgColor
        view.addSubview(overlay)
        overlay.pin(to: view)
        
        let blurEffect = UIBlurEffect(style: Constants.AuthOverlay.BlurEffectView.style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        overlay.addSubview(blurEffectView)
        blurEffectView.pin(to: overlay)
        
        // Индикатор загрузки
        let activityIndicator = UIActivityIndicatorView(style: Constants.AuthOverlay.ActivityIndicator.style)
        activityIndicator.color = Constants.AuthOverlay.ActivityIndicator.color
        activityIndicator.startAnimating()
        overlay.addSubview(activityIndicator)
        activityIndicator.pinCenterX(to: overlay.safeAreaLayoutGuide.centerXAnchor)
        activityIndicator.pinCenterY(to: overlay.safeAreaLayoutGuide.centerYAnchor, Constants.AuthOverlay.ActivityIndicator.YCenterIndent)
        
        let authLabel = UILabel()
        authLabel.text = Constants.AuthOverlay.AuthLabel.text
        authLabel.font = UIFont.systemFont(ofSize: Constants.AuthOverlay.AuthLabel.fontSize)
        authLabel.textColor = Constants.AuthOverlay.AuthLabel.textColor
        overlay.addSubview(authLabel)
        authLabel.pinTop(to: activityIndicator.bottomAnchor, Constants.AuthOverlay.AuthLabel.topIndent)
        authLabel.pinCenterX(to: overlay.safeAreaLayoutGuide.centerXAnchor)
        
        authOverlay = overlay
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
        
        emailTextField.text = email
        emailTextField.backgroundColor = Constants.EmailTextField.bgColor
        emailTextField.layer.cornerRadius = Constants.EmailTextField.cornerRadius
        emailTextField.layer.borderWidth = Constants.EmailTextField.borderWidth
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
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
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
        passwordTextField.layer.borderWidth = Constants.PasswordTextField.borderWidth
        passwordTextField.keyboardType = Constants.PasswordTextField.keyboardType
        passwordTextField.autocorrectionType = Constants.PasswordTextField.autocorrectionType
        passwordTextField.autocapitalizationType = Constants.PasswordTextField.autocapitalizationType
        passwordTextField.attributedPlaceholder = NSAttributedString(string: Constants.PasswordTextField.placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        passwordTextField.setCustomVisibilityButton(mode: Constants.PasswordTextField.secureButtonMode, color: Constants.PasswordTextField.secureButtonColor, padding: Constants.PasswordTextField.paddingRightView)
        passwordTextField.isSecureTextEntry = Constants.PasswordTextField.isSecureText
        passwordTextField.textAlignment = Constants.PasswordTextField.textAlignment
        passwordTextField.setLeftPadding(left: Constants.PasswordTextField.paddingLeft)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        passwordTextField.setHeight(Constants.PasswordTextField.height)
        passwordTextField.pinTop(to: passwordLabel.bottomAnchor, Constants.PasswordTextField.topIndent)
        passwordTextField.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        passwordTextField.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.PasswordTextField.leadingIndent)
    }
    
    private func configureEmailNotExistsLabel() {
        view.addSubview(emailNotExistsLabel)
        
        let fullText = NSMutableAttributedString(
            string: Constants.EmailNotExistsLabel.textPrimary,
            attributes: [
                .foregroundColor: Constants.EmailNotExistsLabel.textColorPrimary,
                .font: Constants.EmailNotExistsLabel.font
            ]
        )
        
        let registerText = NSAttributedString(
            string: Constants.EmailNotExistsLabel.textSecondary,
            attributes: [
                .foregroundColor: Constants.EmailNotExistsLabel.textColorSecondary,
                .font: Constants.EmailNotExistsLabel.font,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        
        fullText.append(registerText)
        emailNotExistsLabel.attributedText = fullText
        emailNotExistsLabel.textAlignment = Constants.EmailNotExistsLabel.textAlignment
        emailNotExistsLabel.alpha = Constants.EmailNotExistsLabel.transparencyMin
        emailNotExistsLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerTapped(_:)))
        emailNotExistsLabel.addGestureRecognizer(tapGesture)
        
        emailNotExistsLabelConstraint = emailNotExistsLabel.pinBottom(to: passwordTextField.bottomAnchor)
        emailNotExistsLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EmailNotExistsLabel.leadingIndent)
        emailNotExistsLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
    }
    
    private func configureWrongPasswordLabel() {
        view.addSubview(wrongPasswordLabel)
        view.bringSubviewToFront(emailTextField)
        
        let fullText = NSMutableAttributedString(
            string: Constants.WrongPasswordLabel.textPrimary,
            attributes: [
                .foregroundColor: Constants.WrongPasswordLabel.textColorPrimary,
                .font: Constants.WrongPasswordLabel.font
            ]
        )
        
        let recoverAccountText = NSAttributedString(
            string: Constants.WrongPasswordLabel.textSecondary,
            attributes: [
                .foregroundColor: Constants.WrongPasswordLabel.textColorSecondary,
                .font: Constants.WrongPasswordLabel.font,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        
        fullText.append(recoverAccountText)
        wrongPasswordLabel.attributedText = fullText
        wrongPasswordLabel.textAlignment = Constants.WrongPasswordLabel.textAlignment
        wrongPasswordLabel.alpha = Constants.WrongPasswordLabel.transparencyMin
        wrongPasswordLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(restorePasswordButtonPressed))
        wrongPasswordLabel.addGestureRecognizer(tapGesture)
        
        wrongPasswordLabelConstraint = wrongPasswordLabel.pinBottom(to: passwordTextField.bottomAnchor)
        wrongPasswordLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.WrongPasswordLabel.leadingIndent)
        wrongPasswordLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.backgroundColor = Constants.LoginButton.bgColor
        loginButton.tintColor = Constants.LoginButton.tintColor
        loginButton.setTitle(Constants.LoginButton.title, for: .normal)
        loginButton.layer.cornerRadius = Constants.LoginButton.cornerRadius
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        textFieldDidChange()
        
        loginButton.setHeight(Constants.LoginButton.height)
        loginButton.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        loginButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.LoginButton.leadingIndent)
        loginButton.pinTop(to: emailNotExistsLabel.bottomAnchor, Constants.LoginButton.topIndent)
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
    
    @objc private func textFieldDidChange() {
        // Убираем сообщения об ошибке после изменения текста в поле
        emailNotExistsLabelConstraint?.isActive = false
        emailNotExistsLabelConstraint = emailNotExistsLabel.pinBottom(to: passwordTextField.bottomAnchor)
        wrongPasswordLabelConstraint?.isActive = false
        wrongPasswordLabelConstraint = wrongPasswordLabel.pinBottom(to: passwordTextField.bottomAnchor)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.emailTextField.layer.borderColor = Constants.EmailTextField.standardBorderColor
            self.passwordTextField.layer.borderColor = Constants.PasswordTextField.standardBorderColor
            self.emailNotExistsLabel.alpha = Constants.EmailNotExistsLabel.transparencyMin
            self.wrongPasswordLabel.alpha = Constants.WrongPasswordLabel.transparencyMin
            self.view.layoutIfNeeded()
        }
        // Отключаем кнопку "Войти" после изменения текста в поле
        loginButton.isEnabled = false
        loginButton.alpha = Constants.LoginButton.transparencyMin
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // Создаём новую проверку валидности email (если текст в поле корректный)
        guard email.isValidEmail() else { return }
        guard password.count != 0 else { return }
        
        loginButton.isEnabled = true
        loginButton.alpha = Constants.LoginButton.transparencyMax
    }
    
    @objc private func registerTapped(_ sender: UITapGestureRecognizer) {
        guard let email = emailTextField.text else { return }
        interactor.showRegistrationScreen(LoginModels.RouteToRegistrationScreen.Request(email: email))
    }
    
    @objc private func loginButtonPressed() {
        guard let email = emailTextField.text else { return }
        interactor.checkEmailExists(LoginModels.CheckEmailExists.Request(email: email))
    }
    
    @objc private func restorePasswordButtonPressed() {
        guard let email = emailTextField.text else { return }
        interactor.showRestorePasswordScreen(LoginModels.RouteToRestorePasswordScreen.Request(email: email))
    }
    
    @objc private func registerButtonPressed() {
        interactor.showRegistrationScreen(LoginModels.RouteToRegistrationScreen.Request(email: nil))
    }
}
