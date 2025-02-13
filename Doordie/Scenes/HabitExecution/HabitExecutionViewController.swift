//
//  HabitExecutionViewController.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

final class HabitExecutionViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum CloseScreenButton {
            static let tintColor: UIColor = .white
            static let imageName: String = "chevron.left"
        }
        
        enum EditHabitButton {
            static let tintColor: UIColor = .white
            static let imageName: String = "square.and.pencil"
        }
        
        enum DeleteHabitButton {
            static let tintColor: UIColor = .systemRed
            static let imageName: String = "trash"
        }
        
        enum HabitTitleLabel {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let fontSize: CGFloat = 24
            static let fontWeigth: UIFont.Weight = .medium
            static let topIndent: CGFloat = 18
            static let leadingIndent: CGFloat = 18
        }
        
        enum ColoredWrap {
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 12
            static let bottomIndent: CGFloat = 18
        }
        
        enum ButtonsStack {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let distribution: UIStackView.Distribution = .fillEqually
            static let alignment: UIStackView.Alignment = .center
            static let spacing: CGFloat = 18
            static let leadingIndent: CGFloat = 18
            static let bottomIndent: CGFloat = 18
        }
        
        enum PauseButton {
            static let bgColor: UIColor = UIColor(hex: "3A50C2")
            static let imageName: String = "pause.fill"
            static let tintColor: UIColor = .white
            static let cornerRadius: CGFloat = 20
            static let height: CGFloat = 70
        }
        
        enum ResumeButton {
            static let bgColor: UIColor = .white
            static let imageName: String = "play.fill"
            static let tintColor: UIColor = UIColor(hex: "3A50C2")
            static let cornerRadius: CGFloat = 20
            static let height: CGFloat = 70
        }
        
        enum RemainTimeValue {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
            static let fontSize: CGFloat = 100
            static let fontWeigth: UIFont.Weight = .bold
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 18
        }
        
        enum RemainTimeLabel {
            static let text: String = "remain"
            static let textColor: UIColor = UIColor(hex: "B3B3B3")
            static let textAlignment: NSTextAlignment = .center
            static let fontSize: CGFloat = 30
            static let fontWeigth: UIFont.Weight = .regular
            static let topIndent: CGFloat = 8
        }
    }
    
    let habit: Habit
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let closeScreenButton: UIButton = UIButton(type: .system)
    private let editHabitButton: UIButton = UIButton(type: .system)
    private let deleteHabitButton: UIButton = UIButton(type: .system)
    private let habitTitleLabel: UILabel = UILabel()
    private let coloredWrap: UIView = UIView()
    private let buttonsStack: UIStackView = UIStackView()
    private let pauseButton: UIButton = UIButton(type: .system)
    private let resumeButton: UIButton = UIButton(type: .system)
    private let remainTimeValue: UILabel = UILabel()
    private let remainTimeLabel: UILabel = UILabel()
    
    // MARK: - Properties
    private var interactor: HabitExecutionBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: HabitExecutionBusinessLogic, habit: Habit) {
        self.interactor = interactor
        self.habit = habit
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
    
    // MARK: - Public Methods
    func displayHabitsAfterDeleting(_ viewModel: HabitExecutionModels.ShowDeleteConfirmationMessage.ViewModel) {
        NotificationCenter.default.post(name: .habitDeleted, object: nil)
        
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureCloseScreenButton()
        configureEditHabitButton()
        configureDeleteHabitButton()
        configureHabitTitleLabel()
        configureRightNavBarButtons()
        configurePauseButton()
        configureResumeButton()
        configureButtonsStack()
        configureColoredWrap()
        configureRemainTimeValue()
        configureRemainTimeLabel()
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
    
    private func configureCloseScreenButton() {
        closeScreenButton.setImage(UIImage(systemName: Constants.CloseScreenButton.imageName), for: .normal)
        closeScreenButton.tintColor = Constants.CloseScreenButton.tintColor
        closeScreenButton.addTarget(self, action: #selector(closeScreenButtonPressed), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: closeScreenButton)
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func configureEditHabitButton() {
        editHabitButton.setImage(UIImage(systemName: Constants.EditHabitButton.imageName), for: .normal)
        editHabitButton.tintColor = Constants.EditHabitButton.tintColor
        editHabitButton.addTarget(self, action: #selector(editHabitButtonPressed), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: editHabitButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func configureDeleteHabitButton() {
        deleteHabitButton.setImage(UIImage(systemName: Constants.DeleteHabitButton.imageName), for: .normal)
        deleteHabitButton.tintColor = Constants.DeleteHabitButton.tintColor
        deleteHabitButton.addTarget(self, action: #selector(deleteHabitButtonPressed), for: .touchUpInside)
    }
    
    private func configureRightNavBarButtons() {
        let editBarButton = UIBarButtonItem(customView: editHabitButton)
        let deleteBarButton = UIBarButtonItem(customView: deleteHabitButton)
        
        navigationItem.rightBarButtonItems = [deleteBarButton, editBarButton]
    }
    
    private func configureHabitTitleLabel() {
        view.addSubview(habitTitleLabel)
        
        habitTitleLabel.text = habit.title
        habitTitleLabel.textColor = Constants.HabitTitleLabel.textColor
        habitTitleLabel.textAlignment = Constants.HabitTitleLabel.textAlignment
        habitTitleLabel.font = UIFont.systemFont(ofSize: Constants.HabitTitleLabel.fontSize, weight: Constants.HabitTitleLabel.fontWeigth)
        
        habitTitleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.HabitTitleLabel.topIndent)
        habitTitleLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.HabitTitleLabel.leadingIndent)
    }
    
    private func configurePauseButton() {
        pauseButton.setImage(UIImage(systemName: Constants.PauseButton.imageName), for: .normal)
        pauseButton.tintColor = Constants.PauseButton.tintColor
        pauseButton.backgroundColor = Constants.PauseButton.bgColor
        pauseButton.layer.cornerRadius = Constants.PauseButton.cornerRadius
        pauseButton.setHeight(Constants.PauseButton.height)
    }
    
    private func configureResumeButton() {
        resumeButton.setImage(UIImage(systemName: Constants.ResumeButton.imageName), for: .normal)
        resumeButton.tintColor = Constants.ResumeButton.tintColor
        resumeButton.backgroundColor = Constants.ResumeButton.bgColor
        resumeButton.layer.cornerRadius = Constants.ResumeButton.cornerRadius
        resumeButton.setHeight(Constants.ResumeButton.height)
    }
    
    private func configureButtonsStack() {
        view.addSubview(buttonsStack)
        
        buttonsStack.addArrangedSubview(pauseButton)
        buttonsStack.addArrangedSubview(resumeButton)
        
        buttonsStack.axis = Constants.ButtonsStack.axis
        buttonsStack.spacing = Constants.ButtonsStack.spacing
        buttonsStack.alignment = Constants.ButtonsStack.alignment
        buttonsStack.distribution = Constants.ButtonsStack.distribution
        
        buttonsStack.isUserInteractionEnabled = true
        
        buttonsStack.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        buttonsStack.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.ButtonsStack.leadingIndent)
        buttonsStack.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.ButtonsStack.bottomIndent)
    }
    
    private func configureColoredWrap() {
        view.addSubview(coloredWrap)
        
        coloredWrap.backgroundColor = Constants.ColoredWrap.bgColor
        coloredWrap.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        
        coloredWrap.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        coloredWrap.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.ColoredWrap.leadingIndent)
        coloredWrap.pinTop(to: habitTitleLabel.bottomAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinBottom(to: buttonsStack.topAnchor, Constants.ColoredWrap.bottomIndent)
    }
    
    private func configureRemainTimeValue() {
        view.addSubview(remainTimeValue)
        
        remainTimeValue.text = "1:15:00"
        remainTimeValue.textColor = Constants.RemainTimeValue.textColor
        remainTimeValue.textAlignment = Constants.RemainTimeValue.textAlignment
        remainTimeValue.font = UIFont.systemFont(ofSize: Constants.RemainTimeValue.fontSize, weight: Constants.RemainTimeValue.fontWeigth)
        remainTimeValue.adjustsFontSizeToFitWidth = true
        remainTimeValue.numberOfLines = Constants.RemainTimeValue.numberOfLines
        
        remainTimeValue.pinCenterY(to: coloredWrap.centerYAnchor)
        remainTimeValue.pinCenterX(to: coloredWrap.centerXAnchor)
        remainTimeValue.pinLeft(to: coloredWrap.leadingAnchor, Constants.RemainTimeValue.leadingIndent)
    }
    
    private func configureRemainTimeLabel() {
        view.addSubview(remainTimeLabel)
        
        remainTimeLabel.text = Constants.RemainTimeLabel.text
        remainTimeLabel.textColor = Constants.RemainTimeLabel.textColor
        remainTimeLabel.textAlignment = Constants.RemainTimeLabel.textAlignment
        remainTimeLabel.font = UIFont.systemFont(ofSize: Constants.RemainTimeLabel.fontSize, weight: Constants.RemainTimeLabel.fontWeigth)
        
        remainTimeLabel.pinCenterX(to: coloredWrap.centerXAnchor)
        remainTimeLabel.pinTop(to: remainTimeValue.bottomAnchor, Constants.RemainTimeLabel.topIndent)
    }
    
    // MARK: - Actions
    @objc
    private func closeScreenButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc
    private func editHabitButtonPressed() {
        interactor.showEditHabitScreen(HabitExecutionModels.ShowEditHabitScreen.Request(habit: habit))
    }
    
    @objc
    private func deleteHabitButtonPressed() {
        interactor.showDeleteConfirmationMessage(HabitExecutionModels.ShowDeleteConfirmationMessage.Request(habit: habit))
    }
}
