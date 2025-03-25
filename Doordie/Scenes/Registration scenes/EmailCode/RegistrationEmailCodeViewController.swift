//
//  EmailCodeViewController.swift
//  Doordie
//
//  Created by Arseniy on 07.03.2025.
//

import UIKit

final class RegistrationEmailCodeViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Code"
            static let tintColor: UIColor = .white
        }
        
        enum EnterCodeLabel {
            static let text: String = "Enter code"
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 36
            static let fontWeight: UIFont.Weight = .bold
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 8
        }
        
        enum StackCodeTextFields {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let alignment: UIStackView.Alignment = .center
            static let distribution: UIStackView.Distribution = .equalSpacing
            static let spacing: CGFloat = 8
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 18
            static let numberOfTextFields: Int = 4
        }
        
        enum CodeTextField {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
            static let fontSize: CGFloat = 24
            static let keyboardType: UIKeyboardType = .numberPad
            static let height: CGFloat = 100
            static let width: CGFloat = 80
            static let cornerRadius: CGFloat = 10
            static let backgroundColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.7)
            static let borderWidth: CGFloat = 2
            static let standardBorderColor: CGColor = UIColor.clear.cgColor
            static let focusedBorderColor: CGColor = UIColor.white.cgColor
            static let errorBorderColor: CGColor = UIColor.red.cgColor
            static let successBorderColor: CGColor = UIColor.systemGreen.cgColor
        }
        
        enum CodeSentLabel {
            static let text: String = "Your code was sent to "
            static let standardTextColor: UIColor = UIColor(hex: "9F9F9F")
            static let emailTextColor: UIColor = .white
            static let fontSize: CGFloat = 14
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 0
        }
        
        enum ResendLabel {
            static let textAlignment: NSTextAlignment = .left
            static let isUserInteractionEnabled: Bool = true
            static let topIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 18
            static let fontSize: CGFloat = 14
            static let primaryColor: UIColor = UIColor(hex: "9F9F9F")
            static let secondaryColor: UIColor = .white
            static let prefix: String = "Resend code in "
            static let suffix: String = " s"
            static let timeIsUpText: String = "Resend code"
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
        
        enum Timer {
            static let resendInterval: Double = 59.0
            static let resendIntervalStep: Double = 1.0
            static let timeIsUpValue: Double = 0.0
        }
        
        enum StagesStack {
            static let numberOfStages: Int = 4
            static let numberOfCompletedStages: Int = 2
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
    private let enterCodeLabel: UILabel = UILabel()
    private let stackCodeTextFields: UIStackView = UIStackView()
    private var codeTextFields: [UITextField] = []
    private let codeSentLabel: UILabel = UILabel()
    private let resendLabel: UILabel = UILabel()
    private let nextButton: UIButton = UIButton(type: .system)
    private let stagesStack: UIStackView = UIStackView()
    
    // MARK: - Properties
    private var interactor: RegistrationEmailCodeBusinessLogic
    private var correctCode: String = "5252"
    private var email: String
    private var isErrorState: Bool = false // сигнализирует об ошибке ввода
    private var resendTimer: Timer?
    private var countdownValue: Double = Constants.Timer.resendInterval
    
    // MARK: - Lifecycle
    init(interactor: RegistrationEmailCodeBusinessLogic, email: String) {
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
        startResendTimer() // Запускаем таймер на повторную отправку кода
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureEnterCodeLabel()
        configreCodeSentLabel()
        configureStackCodeTextFields()
        configureResendLabel()
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
    
    private func configureEnterCodeLabel() {
        view.addSubview(enterCodeLabel)
        
        enterCodeLabel.text = Constants.EnterCodeLabel.text
        enterCodeLabel.textColor = Constants.EnterCodeLabel.textColor
        enterCodeLabel.textAlignment = Constants.EnterCodeLabel.textAlignment
        enterCodeLabel.font = UIFont.systemFont(ofSize: Constants.EnterCodeLabel.fontSize, weight: Constants.EnterCodeLabel.fontWeight)
        enterCodeLabel.numberOfLines = Constants.EnterCodeLabel.numberOfLines
        
        enterCodeLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        enterCodeLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.EnterCodeLabel.leadingIndent)
        enterCodeLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.EnterCodeLabel.topIndent)
    }
    
    private func configreCodeSentLabel() {
        view.addSubview(codeSentLabel)
        
        codeSentLabel.textAlignment = Constants.CodeSentLabel.textAlignment
        codeSentLabel.numberOfLines = Constants.CodeSentLabel.numberOfLines
        
        // Настройка текста
        let attributedText = NSMutableAttributedString(
            string: Constants.CodeSentLabel.text,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.CodeSentLabel.standardTextColor,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.CodeSentLabel.fontSize)]
        )
        let emailAttributedText = NSAttributedString(
            string: email,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.CodeSentLabel.emailTextColor,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.CodeSentLabel.fontSize)]
        )
        attributedText.append(emailAttributedText)
        codeSentLabel.attributedText = attributedText
        
        codeSentLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        codeSentLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.CodeSentLabel.leadingIndent)
        codeSentLabel.pinTop(to: enterCodeLabel.bottomAnchor, Constants.CodeSentLabel.topIndent)
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.backgroundColor = Constants.NextButton.bgColor
        nextButton.tintColor = Constants.NextButton.tintColor
        nextButton.setTitle(Constants.NextButton.title, for: .normal)
        nextButton.setTitle(Constants.NextButton.title, for: .disabled)
        nextButton.layer.cornerRadius = Constants.NextButton.cornerRadius
        nextButton.isEnabled = false
        nextButton.alpha = Constants.NextButton.transparencyMin
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        nextButton.setHeight(Constants.NextButton.height)
        nextButton.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        nextButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.NextButton.leadingIndent)
        nextButton.pinTop(to: resendLabel.bottomAnchor, Constants.NextButton.topIndent)
    }
    
    private func configureStackCodeTextFields() {
        stackCodeTextFields.axis = Constants.StackCodeTextFields.axis
        stackCodeTextFields.alignment = Constants.StackCodeTextFields.alignment
        stackCodeTextFields.distribution = Constants.StackCodeTextFields.distribution
        stackCodeTextFields.spacing = Constants.StackCodeTextFields.spacing
        
        view.addSubview(stackCodeTextFields)
        stackCodeTextFields.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.StackCodeTextFields.leadingIndent)
        stackCodeTextFields.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        stackCodeTextFields.pinTop(to: codeSentLabel.bottomAnchor, Constants.StackCodeTextFields.topIndent)
        
        // Настройка 4 тестовых полей
        for i in 0..<Constants.StackCodeTextFields.numberOfTextFields {
            let textField = EmailCodeTextField()
            textField.layer.cornerRadius = Constants.CodeTextField.cornerRadius
            textField.textColor = Constants.CodeTextField.textColor
            textField.textAlignment = Constants.CodeTextField.textAlignment
            textField.font = UIFont.systemFont(ofSize: Constants.CodeTextField.fontSize)
            textField.keyboardType = Constants.CodeTextField.keyboardType
            textField.delegate = self
            textField.backspaceDelegate = self
            textField.layer.borderWidth = Constants.CodeTextField.borderWidth
            textField.layer.borderColor = Constants.CodeTextField.standardBorderColor
            textField.backgroundColor = Constants.CodeTextField.backgroundColor
            textField.setHeight(Constants.CodeTextField.height)
            textField.setWidth(Constants.CodeTextField.width)
            textField.tag = i // для идентификации порядкового номера текстового поля
            
            // Ограничение ввода более чем одного символа
            textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
            
            codeTextFields.append(textField)
            stackCodeTextFields.addArrangedSubview(textField)
        }
    }
    
    private func configureResendLabel() {
        resendLabel.textAlignment = Constants.ResendLabel.textAlignment
        updateResendLabel()
        resendLabel.isUserInteractionEnabled = Constants.ResendLabel.isUserInteractionEnabled
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resendLabelTapped))
        resendLabel.addGestureRecognizer(tapGesture)
        
        view.addSubview(resendLabel)
        resendLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.ResendLabel.leadingIndent)
        resendLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        resendLabel.pinTop(to: stackCodeTextFields.bottomAnchor, Constants.ResendLabel.topIndent)
    }
    
    private func configureStagesStack() {
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
        
        view.addSubview(stagesStack)
        stagesStack.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        stagesStack.pinTop(to: nextButton.bottomAnchor, Constants.StagesStack.topIndent)
    }
    
    // Метод для обновления текста resendLabel согласно текущему значению countdownValue
    private func updateResendLabel() {
        let attributedText: NSAttributedString
        // Если время еще не закончилось
        if countdownValue > Constants.Timer.timeIsUpValue {
            let prefix = Constants.ResendLabel.prefix
            let numberString = "\(Int(countdownValue))"
            let suffix = Constants.ResendLabel.suffix
            
            let fullString = NSMutableAttributedString(
                string: prefix,
                attributes: [
                    .foregroundColor: Constants.ResendLabel.primaryColor,
                    .font: UIFont.systemFont(ofSize: Constants.ResendLabel.fontSize)
                ]
            )
            
            let numberAttr = NSAttributedString(
                string: numberString,
                attributes: [
                    .foregroundColor: Constants.ResendLabel.secondaryColor,
                    .font: UIFont.systemFont(ofSize: Constants.ResendLabel.fontSize)
                ]
            )
            
            let suffixAttr = NSAttributedString(
                string: suffix,
                attributes: [
                    .foregroundColor: Constants.ResendLabel.primaryColor,
                    .font: UIFont.systemFont(ofSize: Constants.ResendLabel.fontSize)
                ]
            )
            
            fullString.append(numberAttr)
            fullString.append(suffixAttr)
            attributedText = fullString
        } else { // Если время уже вышло
            attributedText = NSAttributedString(
                string: Constants.ResendLabel.timeIsUpText,
                attributes: [
                    .foregroundColor: Constants.ResendLabel.secondaryColor,
                    .font: UIFont.systemFont(ofSize: Constants.ResendLabel.fontSize)
                ]
            )
        }
        resendLabel.attributedText = attributedText
    }
    
    // Метод для запуска таймера
    private func startResendTimer() {
        countdownValue = Constants.Timer.resendInterval
        updateResendLabel()
        
        resendTimer?.invalidate() // инвалидируем таймер, если он уже был запущен
        resendTimer = Timer.scheduledTimer(withTimeInterval: Constants.Timer.resendIntervalStep, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.countdownValue -= Constants.Timer.resendIntervalStep
            self.updateResendLabel()
            if self.countdownValue <= Constants.Timer.timeIsUpValue {
                timer.invalidate()
                self.resendTimer = nil
            }
        }
    }
    
    // Метод для проверки заполненности всех полей
    private func checkForCompletion() {
        let code = codeTextFields.compactMap { $0.text }.joined()
        if code.count == Constants.StackCodeTextFields.numberOfTextFields {
            view.endEditing(true)
            if code == correctCode {
                codeTextFields.forEach { textField in
                    textField.layer.borderColor = Constants.CodeTextField.successBorderColor
                }
                nextButton.isEnabled = true
                nextButton.alpha = Constants.NextButton.transparencyMax
                interactor.routeToRegistrationNameScreen(RegistrationEmailCodeModels.RouteToRegistrationNameScreen.Request(email: email))
            } else {
                nextButton.isEnabled = false
                nextButton.alpha = Constants.NextButton.transparencyMin
                animateShakeAndShowError()
            }
        } else {
            nextButton.isEnabled = false
            nextButton.alpha = Constants.NextButton.transparencyMin
        }
    }
    
    // Метод анимации "дрожания" stackView и выставления красных границ
    private func animateShakeAndShowError() {
        codeTextFields.forEach { textField in
            textField.layer.borderColor = Constants.CodeTextField.errorBorderColor
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                self.stackCodeTextFields.transform = CGAffineTransform(translationX: -10, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1) {
                self.stackCodeTextFields.transform = CGAffineTransform(translationX: 10, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1) {
                self.stackCodeTextFields.transform = CGAffineTransform(translationX: -10, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1) {
                self.stackCodeTextFields.transform = CGAffineTransform(translationX: 10, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
                self.stackCodeTextFields.transform = .identity
            }
        }, completion: { _ in
            self.isErrorState = true
        })
    }
    
    // Сброс красного оформления при выборе поля
    private func removeErrorStyling() {
        codeTextFields.forEach { textField in
            textField.layer.borderColor = Constants.CodeTextField.standardBorderColor
        }
        isErrorState = false
    }
    
    // MARK: - Actions
    
    // Обработка изменения текстового поля - оставляем только первый символ
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, text.count > 1 {
            textField.text = String(text.prefix(1))
        }
        // При любом вводе сбрасываем красные края
        removeErrorStyling()
    }
    
    // Метод для скрытия клавиатуры при нажатии на экран
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Обработка нажатия на resendLabel
    @objc private func resendLabelTapped() {
        if resendTimer == nil {
            print("code was sent")
            startResendTimer()
        }
    }
    
    @objc private func nextButtonPressed() {
        checkForCompletion()
    }
}


// MARK: - UITextFieldDelegate
extension RegistrationEmailCodeViewController: UITextFieldDelegate {
    // Добавляем край при фокусировании на поле
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Если ввод был с ошибкой, очищаем все поля, начиная с текущего поля
        if isErrorState {
            for field in codeTextFields where field.tag >= textField.tag {
                field.text = ""
            }
        }
        removeErrorStyling()
        textField.layer.borderColor = Constants.CodeTextField.focusedBorderColor
    }
    
    // Убираем край при потере фокуса
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Constants.CodeTextField.standardBorderColor
    }
    
    // Обработка ввода (перенос назад при нажатии на клавишу "стереть" и перенос вперед при вводе цифры)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Обработка удаления (нажатие на клавишу "стереть")
        if string.isEmpty {
            // Если поле уже пустое, переводим фокус на предыдущее
            if textField.text?.isEmpty ?? true {
                if let previousField = previousTextField(for: textField) {
                    previousField.becomeFirstResponder()
                    previousField.text = "" // Очищаем предыдущее поле, чтобы удалить предыдущую введенную цифру
                }
                return false
            } else {
                // Если в поле есть символ – просто удаляем его
                textField.text = ""
                return false
            }
        }
        
        // Ввести можно только цифры
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
            return false
        }
        
        textField.text = string
        
        // Переводим фокус на следующее поле, если оно существует
        if let nextField = nextTextField(for: textField) {
            nextField.becomeFirstResponder()
        } else {
            // Если достигли последнего поля, скрываем клавиатуру
            textField.resignFirstResponder()
        }
        
        checkForCompletion() // Проверяем, заполнены ли все поля
        return false
    }
    
    // Метод для получения следующего текстового поля по порядковому номеру (tag)
    private func nextTextField(for textField: UITextField) -> UITextField? {
        let nextTag = textField.tag + 1
        return codeTextFields.first(where: { $0.tag == nextTag })
    }
    
    // Метод для получения предыдущего текстового поля по порядковому номеру (tag)
    private func previousTextField(for textField: UITextField) -> UITextField? {
        let previousTag = textField.tag - 1
        return codeTextFields.first(where: { $0.tag == previousTag })
    }
}

// MARK: - EmailCodeTextFieldDelegate
extension RegistrationEmailCodeViewController: EmailCodeTextFieldDelegate {
    func didPressBackspace(_ textField: EmailCodeTextField) {
        // Если поле пустое и пользователь нажал "стереть", переходим к предыдущему полю
        if let previousField = previousTextField(for: textField) {
            previousField.text = ""
            previousField.becomeFirstResponder()
        }
    }
}
