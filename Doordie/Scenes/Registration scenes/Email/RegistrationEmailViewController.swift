//
//  RegistrationEmailViewController.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationEmailViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Email"
            static let tintColor: UIColor = .white
        }
        
        enum EmailLabel {
            static let text: String = "What is your email?"
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 36
            static let fontWeight: UIFont.Weight = .bold
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
            static let topIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 18
        }
        
        enum EmailExistsLabel {
            static let textPrimary: String = "This email is already registered:  "
            static let textSecondary: String = "Sign in"
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
            static let text: String = "You will receive a 4-digit code"
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 14
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum NextButton {
            static let bgColor: UIColor = UIColor(hex: "3A50C2")
            static let title: String = "Next"
            static let tintColor: UIColor = .white
            static let height: CGFloat = 50
            static let transparencyMin: CGFloat = 0.5
            static let transparencyMax: CGFloat = 1
            static let cornerRadius: CGFloat = 14
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 18
        }
        
        enum StagesStack {
            static let numberOfStages: Int = 4
            static let numberOfCompletedStages: Int = 1
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let distribution: UIStackView.Distribution = .fillEqually
            static let alignment: UIStackView.Alignment = .center
            static let spacing: CGFloat = 12
            static let topIndent: CGFloat = 18
        }
        
        enum CurrentStage {
            static let bgColorCompletedStage: UIColor = UIColor(hex: "3A50C2")
            static let bgColorUncompletedStage: UIColor = .white
            static let height: CGFloat = 4
            static let width: CGFloat = 30
            static let cornerRadius: CGFloat = 2
        }
    }
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let emailLabel: UILabel = UILabel()
    private let emailTextField: UITextField = UITextField()
    private let emailExistsLabel: UILabel = UILabel()
    private let instructionLabel: UILabel = UILabel()
    private let nextButton: UIButton = UIButton(type: .system)
    private let stagesStack: UIStackView = UIStackView()
    
    // MARK: - Properties
    private var interactor: RegistrationEmailBusinessLogic
    private var emailExistsLabelConstraint: NSLayoutConstraint?
    private var emailValidationWorkItem: DispatchWorkItem?
    private var email: String?
    
    // MARK: - Lifecycle
    init(interactor: RegistrationEmailBusinessLogic, email: String?) {
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
        configureCloseKeyboardGesture()
    }
    
    // MARK: - Methods
    func displayIfEmailExists(_ viewModel: RegistrationEmailModels.CheckEmailExists.ViewModel) {
        if viewModel.isExists {
            emailExistsLabelConstraint?.isActive = false
            emailExistsLabelConstraint = emailExistsLabel.pinTop(to: emailTextField.bottomAnchor, Constants.EmailExistsLabel.topIndent)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.emailTextField.layer.borderColor = Constants.EmailTextField.errorBorderColor
                self.emailExistsLabel.alpha = Constants.EmailExistsLabel.transparencyMax
                self.view.layoutIfNeeded()
            }
        } else {
            nextButton.isEnabled = true
            nextButton.alpha = Constants.NextButton.transparencyMax
        }
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureEmailLabel()
        configureEmailTextField()
        configureEmailExistsLabel()
        configureInstructionLabel()
        configureNextButton()
        configureStagesStack()
    }
    
    private func configureCloseKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
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
    
    private func configureEmailLabel() {
        view.addSubview(emailLabel)
        
        emailLabel.text = Constants.EmailLabel.text
        emailLabel.textColor = Constants.EmailLabel.textColor
        emailLabel.textAlignment = Constants.EmailLabel.textAlignment
        emailLabel.font = UIFont.systemFont(ofSize: Constants.EmailLabel.fontSize, weight: Constants.EmailLabel.fontWeight)
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
        emailTextField.textColor = Constants.EmailTextField.textColor
        emailTextField.font = UIFont.systemFont(ofSize: Constants.EmailTextField.fontSize)
        emailTextField.layer.borderWidth = Constants.EmailTextField.borderWidth
        emailTextField.keyboardType = Constants.EmailTextField.keyboardType
        emailTextField.autocorrectionType = Constants.EmailTextField.autocorrectionType
        emailTextField.autocapitalizationType = Constants.EmailTextField.autocapitalizationType
        emailTextField.attributedPlaceholder = NSAttributedString(string: Constants.EmailTextField.placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        emailTextField.clearButtonMode = .never
        emailTextField.setCustomClearButton(mode: Constants.EmailTextField.clearButtonMode, color: Constants.EmailTextField.clearButtonColor, padding: Constants.EmailTextField.paddingRight)
        emailTextField.textAlignment = Constants.EmailTextField.textAlignment
        emailTextField.setLeftPadding(left: Constants.EmailTextField.leftTextPadding)
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        
        emailTextField.setHeight(Constants.EmailTextField.height)
        emailTextField.pinTop(to: emailLabel.bottomAnchor, Constants.EmailTextField.topIndent)
        emailTextField.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        emailTextField.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EmailTextField.leadingIndent)
    }
    
    private func configureEmailExistsLabel() {
        view.addSubview(emailExistsLabel)
        view.bringSubviewToFront(emailTextField)
        
        let fullText = NSMutableAttributedString(
            string: Constants.EmailExistsLabel.textPrimary,
            attributes: [
                .foregroundColor: Constants.EmailExistsLabel.textColorPrimary,
                .font: Constants.EmailExistsLabel.font
            ]
        )
        
        let emailText = NSAttributedString(
            string: Constants.EmailExistsLabel.textSecondary,
            attributes: [
                .foregroundColor: Constants.EmailExistsLabel.textColorSecondary,
                .font: Constants.EmailExistsLabel.font,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        fullText.append(emailText)
        emailExistsLabel.attributedText = fullText
        emailExistsLabel.textAlignment = Constants.EmailExistsLabel.textAlignment
        emailExistsLabel.alpha = Constants.EmailExistsLabel.transparencyMin
        emailExistsLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInTapped(_:)))
        emailExistsLabel.addGestureRecognizer(tapGesture)
        
        emailExistsLabelConstraint = emailExistsLabel.pinBottom(to: emailTextField.bottomAnchor)
        emailExistsLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EmailExistsLabel.leadingIndent)
        emailExistsLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
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
        instructionLabel.pinTop(to: emailExistsLabel.bottomAnchor, Constants.InstructionLabel.topIndent)
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.backgroundColor = Constants.NextButton.bgColor
        nextButton.tintColor = Constants.NextButton.tintColor
        nextButton.setTitle(Constants.NextButton.title, for: .normal)
        nextButton.setTitle(Constants.NextButton.title, for: .disabled)
        nextButton.layer.cornerRadius = Constants.NextButton.cornerRadius
        emailTextFieldDidChange() // проверяем что почтовый адрес корректный
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        nextButton.setHeight(Constants.NextButton.height)
        nextButton.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        nextButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.NextButton.leadingIndent)
        nextButton.pinTop(to: instructionLabel.bottomAnchor, Constants.NextButton.topIndent)
    }
    
    private func configureStagesStack() {
        view.addSubview(stagesStack)
        
        for i in 0..<Constants.StagesStack.numberOfStages {
            let stage: UIView = UIView()
            
            if i < Constants.StagesStack.numberOfCompletedStages {
                stage.backgroundColor = Constants.CurrentStage.bgColorCompletedStage
            } else {
                stage.backgroundColor = Constants.CurrentStage.bgColorUncompletedStage
            }
            
            stage.setHeight(Constants.CurrentStage.height)
            stage.setWidth(Constants.CurrentStage.width)
            stage.layer.cornerRadius = Constants.CurrentStage.cornerRadius
            
            stagesStack.addArrangedSubview(stage)
        }
        
        stagesStack.axis = Constants.StagesStack.axis
        stagesStack.spacing = Constants.StagesStack.spacing
        stagesStack.alignment = Constants.StagesStack.alignment
        stagesStack.distribution = Constants.StagesStack.distribution
        
        stagesStack.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        stagesStack.pinTop(to: nextButton.bottomAnchor, Constants.StagesStack.topIndent)
    }
    
    // MARK: - Actions
    @objc private func nextButtonPressed() {
        guard let email = emailTextField.text else { return }
        
        interactor.routeToRegistrationEmailCodeScreen(RegistrationEmailModels.RouteToRegistrationEmailCodeScreen.Request(email: email))
    }
    
    @objc private func signInTapped(_ sender: UITapGestureRecognizer) {
        guard let email = emailTextField.text else { return }
        interactor.routeToLoginScreen(RegistrationEmailModels.RouteToLoginScreen.Request(email: email))
    }
    
    @objc private func emailTextFieldDidChange() {
        // Убираем сообщения об ошибке после изменения текста в поле
        emailExistsLabelConstraint?.isActive = false
        emailExistsLabelConstraint = emailExistsLabel.pinBottom(to: emailTextField.bottomAnchor)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.emailTextField.layer.borderColor = Constants.EmailTextField.standardBorderColor
            self.emailExistsLabel.alpha = Constants.EmailExistsLabel.transparencyMin
            self.view.layoutIfNeeded()
        }
        // Отключаем кнопку "Далее" (пока не придет ответ от сервера)
        nextButton.isEnabled = false
        nextButton.alpha = Constants.NextButton.transparencyMin
        
        guard let email = emailTextField.text else { return }
        
        // Отменяем предыдущую проверку валидности email, если она была
        emailValidationWorkItem?.cancel()
        
        // Создаём новую проверку валидности email (если текст в поле корректный)
        guard email.isValidEmail() else { return }
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            self.interactor.checkEmailExists(RegistrationEmailModels.CheckEmailExists.Request(email: email))
        }
        emailValidationWorkItem = workItem
        
        // Отправляем задачу на выполнение с задержкой (чтобы не спамить сервер)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: workItem)
    }
    
    // Метод для скрытия клавиатуры при нажатии на экран
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
