//
//  PasswordResetViewController.swift
//  Doordie
//
//  Created by Arseniy on 02.03.2025.
//

import UIKit

final class PasswordResetViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Password reset"
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
        
        enum InstructionLabel {
            static let text: String = "You will receive instructions to reset your password"
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 14
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 2
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum SendButton {
            static let bgColor: UIColor = UIColor(hex: "3A50C2")
            static let title: String = "Send"
            static let tintColor: UIColor = .white
            static let height: CGFloat = 50
            static let transparencyMin: CGFloat = 0.5
            static let transparencyMax: CGFloat = 1
            static let cornerRadius: CGFloat = 14
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 18
        }
    }
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let emailLabel: UILabel = UILabel()
    private let emailTextField: UITextField = UITextField()
    private let emailNotExistsLabel: UILabel = UILabel()
    private let instructionLabel: UILabel = UILabel()
    private let sendButton: UIButton = UIButton(type: .custom)
    
    // MARK: - Properties
    private var interactor: PasswordResetBusinessLogic
    private var email: String?
    private var emailNotExistsLabelConstraint: NSLayoutConstraint?
    private var emailValidationWorkItem: DispatchWorkItem?
    
    // MARK: - Lifecycle
    init(interactor: PasswordResetBusinessLogic, email: String?) {
        self.interactor = interactor
        self.email = email
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
    func displayIfEmailExists(_ viewModel: PasswordResetModels.CheckEmailExists.ViewModel) {
        if viewModel.isExists {
            sendButton.isEnabled = true
            sendButton.alpha = Constants.SendButton.transparencyMax
        } else {
            emailNotExistsLabelConstraint?.isActive = false
            emailNotExistsLabelConstraint = emailNotExistsLabel.pinTop(to: emailTextField.bottomAnchor, Constants.EmailNotExistsLabel.topIndent)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.emailTextField.layer.borderColor = Constants.EmailTextField.errorBorderColor
                self.emailNotExistsLabel.alpha = Constants.EmailNotExistsLabel.transparencyMax
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
        configureEmailNotExistsLabel()
        configureInstructionLabel()
        configureSendButton()
        
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
        emailTextField.text = email
        emailTextField.layer.borderWidth = Constants.EmailTextField.borderWidth
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
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        
        emailTextField.setHeight(Constants.EmailTextField.height)
        emailTextField.pinTop(to: emailLabel.bottomAnchor, Constants.EmailTextField.topIndent)
        emailTextField.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        emailTextField.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EmailTextField.leadingIndent)
    }
    
    private func configureEmailNotExistsLabel() {
        view.addSubview(emailNotExistsLabel)
        view.bringSubviewToFront(emailTextField)
        
        let fullText = NSMutableAttributedString(
            string: Constants.EmailNotExistsLabel.textPrimary,
            attributes: [
                .foregroundColor: Constants.EmailNotExistsLabel.textColorPrimary,
                .font: Constants.EmailNotExistsLabel.font
            ]
        )
        
        let emailText = NSAttributedString(
            string: Constants.EmailNotExistsLabel.textSecondary,
            attributes: [
                .foregroundColor: Constants.EmailNotExistsLabel.textColorSecondary,
                .font: Constants.EmailNotExistsLabel.font,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        fullText.append(emailText)
        emailNotExistsLabel.attributedText = fullText
        emailNotExistsLabel.textAlignment = Constants.EmailNotExistsLabel.textAlignment
        emailNotExistsLabel.alpha = Constants.EmailNotExistsLabel.transparencyMin
        emailNotExistsLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerTapped(_:)))
        emailNotExistsLabel.addGestureRecognizer(tapGesture)
        
        emailNotExistsLabelConstraint = emailNotExistsLabel.pinBottom(to: emailTextField.bottomAnchor)
        emailNotExistsLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EmailNotExistsLabel.leadingIndent)
        emailNotExistsLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
    }
    
    private func configureInstructionLabel() {
        view.addSubview(instructionLabel)
        
        instructionLabel.text = Constants.InstructionLabel.text
        instructionLabel.textColor = Constants.InstructionLabel.textColor
        instructionLabel.font = UIFont.systemFont(ofSize: Constants.InstructionLabel.fontSize)
        instructionLabel.textAlignment = Constants.InstructionLabel.textAlignment
        instructionLabel.numberOfLines = Constants.InstructionLabel.numberOfLines
        
        instructionLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        instructionLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.InstructionLabel.leadingIndent)
        instructionLabel.pinTop(to: emailNotExistsLabel.bottomAnchor, Constants.InstructionLabel.topIndent)
    }
    
    private func configureSendButton() {
        view.addSubview(sendButton)
        
        sendButton.backgroundColor = Constants.SendButton.bgColor
        sendButton.tintColor = Constants.SendButton.tintColor
        sendButton.setTitle(Constants.SendButton.title, for: .normal)
        sendButton.setTitle(Constants.SendButton.title, for: .disabled)
        sendButton.layer.cornerRadius = Constants.SendButton.cornerRadius
        emailTextFieldDidChange() // проверяем что почтовый адрес корректный
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        
        sendButton.setHeight(Constants.SendButton.height)
        sendButton.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        sendButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.SendButton.leadingIndent)
        sendButton.pinTop(to: instructionLabel.bottomAnchor, Constants.SendButton.topIndent)
    }
    
    private func configureDismissKeyboardTap() {
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func registerTapped(_ sender: UITapGestureRecognizer) {
        guard let email = emailTextField.text else { return }
        interactor.routeToRegistrationEmailScreen(PasswordResetModels.RouteToRegistrationEmailScreen.Request(email: email))
    }
    
    @objc private func sendButtonPressed() {
        guard let email = emailTextField.text else { return }
        interactor.showSentPopup(PasswordResetModels.PresentSentPopup.Request(mail: email))
    }
    
    @objc private func emailTextFieldDidChange() {
        // Убираем сообщения об ошибке после изменения текста в поле
        emailNotExistsLabelConstraint?.isActive = false
        emailNotExistsLabelConstraint = emailNotExistsLabel.pinBottom(to: emailTextField.bottomAnchor)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.emailTextField.layer.borderColor = Constants.EmailTextField.standardBorderColor
            self.emailNotExistsLabel.alpha = Constants.EmailNotExistsLabel.transparencyMin
            self.view.layoutIfNeeded()
        }
        // Отключаем кнопку "Отправить" (пока не придет ответ от сервера)
        sendButton.isEnabled = false
        sendButton.alpha = Constants.SendButton.transparencyMin
        
        guard let email = emailTextField.text else { return }
        
        // Отменяем предыдущую проверку валидности email, если она была
        emailValidationWorkItem?.cancel()
        
        // Создаём новую проверку валидности email (если текст в поле корректный)
        guard email.isValidEmail() else { return }
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            self.interactor.checkEmailExists(PasswordResetModels.CheckEmailExists.Request(email: email))
        }
        emailValidationWorkItem = workItem
        
        // Отправляем задачу на выполнение с задержкой (чтобы не спамить сервер)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: workItem)
    }
}
