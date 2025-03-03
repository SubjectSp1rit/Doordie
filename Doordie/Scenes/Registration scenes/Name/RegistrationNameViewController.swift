//
//  RegistrationNameViewController.swift
//  Doordie
//
//  Created by Arseniy on 03.03.2025.
//

import UIKit

final class RegistrationNameViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Name"
        }
        
        enum NameLabel {
            static let text: String = "What is your name?"
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 36
            static let fontWeight: UIFont.Weight = .bold
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum NameTextField {
            static let bgColor: UIColor = .white
            static let cornerRadius: CGFloat = 14
            static let textColor: UIColor = .black
            static let fontSize: CGFloat = 22
            static let keyboardType: UIKeyboardType = .emailAddress
            static let autocorrectionType: UITextAutocorrectionType = .no
            static let autocapitalizationType: UITextAutocapitalizationType = .none
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
    }
    
    // MARK: - UI Components
    let background: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let nameTextField: UITextField = UITextField()
    let nextButton: UIButton = UIButton(type: .system)
    
    // MARK: - Properties
    private var interactor: RegistrationNameBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: RegistrationNameBusinessLogic) {
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
        configureNameLabel()
        configureNameTextField()
        configureNextButton()
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
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.text = Constants.NameLabel.text
        nameLabel.textColor = Constants.NameLabel.textColor
        nameLabel.textAlignment = Constants.NameLabel.textAlignment
        nameLabel.font = UIFont.systemFont(ofSize: Constants.NameLabel.fontSize, weight: Constants.NameLabel.fontWeight)
        nameLabel.numberOfLines = Constants.NameLabel.numberOfLines
        
        nameLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        nameLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.NameLabel.leadingIndent)
        nameLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.NameLabel.topIndent)
    }
    
    private func configureNameTextField() {
        view.addSubview(nameTextField)
        
        nameTextField.backgroundColor = Constants.NameTextField.bgColor
        nameTextField.layer.cornerRadius = Constants.NameTextField.cornerRadius
        nameTextField.textColor = Constants.NameTextField.textColor
        nameTextField.font = UIFont.systemFont(ofSize: Constants.NameTextField.fontSize)
        nameTextField.keyboardType = Constants.NameTextField.keyboardType
        nameTextField.autocorrectionType = Constants.NameTextField.autocorrectionType
        nameTextField.autocapitalizationType = Constants.NameTextField.autocapitalizationType
        nameTextField.setCustomClearButton(mode: Constants.NameTextField.clearButtonMode, color: Constants.NameTextField.clearButtonColor, padding: Constants.NameTextField.paddingRight)
        nameTextField.textAlignment = Constants.NameTextField.textAlignment
        nameTextField.setLeftPadding(left: Constants.NameTextField.leftTextPadding)
        nameTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        
        nameTextField.setHeight(Constants.NameTextField.height)
        nameTextField.pinTop(to: nameLabel.bottomAnchor, Constants.NameTextField.topIndent)
        nameTextField.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        nameTextField.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.NameTextField.leadingIndent)
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
        nextButton.pinTop(to: nameTextField.bottomAnchor, Constants.NextButton.topIndent)
    }
    
    // MARK: - Actions
    @objc private func nextButtonPressed() {
        interactor.routeToRegistrationPassword(RegistrationNameModels.RouteToRegistrationPasswordScreen.Request())
    }
    
    @objc private func emailTextFieldDidChange() {
        guard let name = nameTextField.text else { return }
        let minNameLength = 2
        
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
