//
//  RegistrationPasswordViewController.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationPasswordViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Password"
        }
        
        enum PasswordLabel {
            static let text: String = "Create a password"
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 36
            static let fontWeight: UIFont.Weight = .bold
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum PasswordTextField {
            static let bgColor: UIColor = .white
            static let cornerRadius: CGFloat = 14
            static let textColor: UIColor = .black
            static let fontSize: CGFloat = 22
            static let keyboardType: UIKeyboardType = .emailAddress
            static let autocorrectionType: UITextAutocorrectionType = .no
            static let autocapitalizationType: UITextAutocapitalizationType = .none
            static let placeholder: String = "••••••••"
            static let clearButtonMode: UITextField.ViewMode = .whileEditing
            static let paddingRight: CGFloat = 10
            static let clearButtonColor: UIColor = .systemGray
            static let textAlignment: NSTextAlignment = .left
            static let leftTextPadding: CGFloat = 8
            static let minimumBorderWidth: CGFloat = 0
            static let maximumBorderWidth: CGFloat = 2
            static let borderColor: CGColor = UIColor.systemRed.cgColor
            static let height: CGFloat = 50
            static let topIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 18
        }
        
        enum InstructionLabel {
            static let text: String = "Use at least 8 characters"
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
            static let numberOfStages: Int = 3
            static let numberOfCompletedStages: Int = 3
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
    let background: UIImageView = UIImageView()
    let passwordLabel: UILabel = UILabel()
    let passwordTextField: UITextField = UITextField()
    let instructionLabel: UILabel = UILabel()
    let nextButton: UIButton = UIButton(type: .system)
    let stagesStack: UIStackView = UIStackView()
    
    // MARK: - Properties
    private var interactor: RegistrationPasswordBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: RegistrationPasswordBusinessLogic) {
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
        configurePasswordLabel()
        configurePasswordTextField()
        configureInstructionLabel()
        configureNextButton()
        configureStagesStack()
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
    
    private func configurePasswordLabel() {
        view.addSubview(passwordLabel)
        
        passwordLabel.text = Constants.PasswordLabel.text
        passwordLabel.textColor = Constants.PasswordLabel.textColor
        passwordLabel.textAlignment = Constants.PasswordLabel.textAlignment
        passwordLabel.font = UIFont.systemFont(ofSize: Constants.PasswordLabel.fontSize, weight: Constants.PasswordLabel.fontWeight)
        passwordLabel.numberOfLines = Constants.PasswordLabel.numberOfLines
        
        passwordLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        passwordLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.PasswordLabel.leadingIndent)
        passwordLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.PasswordLabel.topIndent)
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
        passwordTextField.setCustomClearButton(mode: Constants.PasswordTextField.clearButtonMode, color: Constants.PasswordTextField.clearButtonColor, padding: Constants.PasswordTextField.paddingRight)
        passwordTextField.textAlignment = Constants.PasswordTextField.textAlignment
        passwordTextField.attributedPlaceholder = NSAttributedString(string: Constants.PasswordTextField.placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        passwordTextField.setLeftPadding(left: Constants.PasswordTextField.leftTextPadding)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        passwordTextField.setHeight(Constants.PasswordTextField.height)
        passwordTextField.pinTop(to: passwordLabel.bottomAnchor, Constants.PasswordTextField.topIndent)
        passwordTextField.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        passwordTextField.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.PasswordTextField.leadingIndent)
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
        instructionLabel.pinTop(to: passwordTextField.bottomAnchor, Constants.InstructionLabel.topIndent)
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.backgroundColor = Constants.NextButton.bgColor
        nextButton.tintColor = Constants.NextButton.tintColor
        nextButton.setTitle(Constants.NextButton.title, for: .normal)
        nextButton.setTitle(Constants.NextButton.title, for: .disabled)
        nextButton.layer.cornerRadius = Constants.NextButton.cornerRadius
        passwordTextFieldDidChange()
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
        // logic
    }
    
    @objc private func passwordTextFieldDidChange() {
        guard let name = passwordTextField.text else { return }
        let minNameLength = 8
        
        switch name.isEmpty || name.count < minNameLength {
        case true:
            nextButton.isEnabled = false
            nextButton.alpha = Constants.NextButton.transparencyMin
        case false:
            nextButton.isEnabled = true
            nextButton.alpha = Constants.NextButton.transparencyMax
        }
    }
}
