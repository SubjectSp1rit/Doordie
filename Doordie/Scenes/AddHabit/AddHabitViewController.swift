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
        
        enum Layout {
            static let scrollDirection: UICollectionView.ScrollDirection = .vertical
            static let minimumLineSpacing: CGFloat = 0
            static let minimumInteritemSpacing: CGFloat = 0
        }
        
        enum Table {
            static let numberOfSections: Int = 7
            static let bgColor: UIColor = .clear
            static let elementsLeadingIndent: CGFloat = 18
            static let elementsTrailingIndent: CGFloat = 18
            static let elementsTopIndent: CGFloat = 12
            static let elementsBottomIndent: CGFloat = 0
            
            // cells indexPath
            static let titleCellSectionIndex: Int = 0
            static let titleCellRowIndex: Int = 0
            
            static let motivationsCellSectionIndex: Int = 1
            static let motivationsCellRowIndex: Int = 0
            
            static let colorCellSectionIndex: Int = 2
            static let colorCellRowIndex: Int = 0
            
            static let iconCellSectionIndex: Int = 2
            static let iconCellRowIndex: Int = 1
            
            static let quantityCellSectionIndex: Int = 3
            static let quantityCellRowIndex: Int = 0
            
            static let measurementCellSectionIndex: Int = 3
            static let measurementCellRowIndex: Int = 1
            
            static let regularityCellSectionIndex: Int = 4
            static let regularityCellRowIndex: Int = 0
            
            static let dayPartCellSectionIndex: Int = 5
            static let dayPartCellRowIndex: Int = 0
            
            static let confirmButtonSectionIndex: Int = 6
            static let confirmButtonRowIndex: Int = 0
            
            static let oneRowInSection: Int = 1
            static let twoRowsInSection: Int = 2
            static let zeroRowsInSection: Int = 0
        }
        
        enum HabitStandardValues {
            static let title: String = ""
            static let motivations: String = ""
            static let color: String = "6475CC"
            static let icon: String = "heart"
            static let quantity: String = "30"
            static let currentQuantity: String = "0"
            static let measurement: String = "Mins"
            static let regularity: String = "Every day"
            static let dayPart: String = "Any time"
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let navBarCenteredTitle: UILabel = UILabel()
    private let navBarDismissButton: UIButton = UIButton(type: .system)
    private let table: UICollectionView
    
    // MARK: - Properties
    private var interactor: AddHabitBusinessLogic
    
    private var habit: Habit? = nil
    private var habitTitle: String? = Constants.HabitStandardValues.title
    private var habitMotivations: String? = Constants.HabitStandardValues.motivations
    private var habitColor: String? = Constants.HabitStandardValues.color
    private var habitIcon: String? = Constants.HabitStandardValues.icon
    private var habitQuantity: String? = Constants.HabitStandardValues.quantity
    private var habitCurrentQuantity: String? = Constants.HabitStandardValues.currentQuantity
    private var habitMeasurementType: String? = Constants.HabitStandardValues.measurement
    private var habitPeriod: String? = Constants.HabitStandardValues.regularity
    private var habitDayPart: String? = Constants.HabitStandardValues.dayPart
    
    // MARK: - Lifecycle
    init(interactor: AddHabitBusinessLogic, habit: Habit? = nil) {
        self.interactor = interactor
        self.table = AddHabitViewController.createCollectionView()
        self.habit = habit
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHabitData()
        configureUI()
        configureCloseButtonTap()
    }
    
    // MARK: - Private Methods
    private static func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = Constants.Layout.scrollDirection
        layout.minimumLineSpacing = Constants.Layout.minimumLineSpacing
        layout.minimumInteritemSpacing = Constants.Layout.minimumInteritemSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        return collectionView
    }
    
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureNavBarDismissButton()
        configureTable()
    }
    
    private func configureHabitData() {
        // Если данные привычки пришли извне - заполняем ячейки этими данными, иначе ставим стандартные значения
        if let habit = habit {
            habitTitle = habit.title ?? Constants.HabitStandardValues.title
            habitMotivations = habit.motivations ?? Constants.HabitStandardValues.motivations
            habitColor = habit.color ?? Constants.HabitStandardValues.color
            habitIcon = habit.icon ?? Constants.HabitStandardValues.icon
            habitQuantity = habit.quantity ?? Constants.HabitStandardValues.quantity
            habitMeasurementType = habit.measurement ?? Constants.HabitStandardValues.measurement
            habitPeriod = habit.regularity ?? Constants.HabitStandardValues.regularity
            habitDayPart = habit.day_part ?? Constants.HabitStandardValues.dayPart
        }
    }
    
    private func configureCloseButtonTap() {
        let closeButtonTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(closeButtonTap)
    }
    
    private func configureBackground() {
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
    
    private func configureTable() {
        view.addSubview(table)
        
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = true
        table.backgroundColor = Constants.Table.bgColor
        table.delegate = self
        table.dataSource = self
        table.register(HabitTitleCell.self, forCellWithReuseIdentifier: HabitTitleCell.reuseId)
        table.register(HabitMotivationsCell.self, forCellWithReuseIdentifier: HabitMotivationsCell.reuseId)
        table.register(HabitColorCell.self, forCellWithReuseIdentifier: HabitColorCell.reuseId)
        table.register(HabitIconCell.self, forCellWithReuseIdentifier: HabitIconCell.reuseId)
        table.register(HabitQuantityCell.self, forCellWithReuseIdentifier: HabitQuantityCell.reuseId)
        table.register(HabitMeasurementCell.self, forCellWithReuseIdentifier: HabitMeasurementCell.reuseId)
        table.register(HabitRegularityCell.self, forCellWithReuseIdentifier: HabitRegularityCell.reuseId)
        table.register(HabitDayPartCell.self, forCellWithReuseIdentifier: HabitDayPartCell.reuseId)
        table.register(HabitConfirmCreationCell.self, forCellWithReuseIdentifier: HabitConfirmCreationCell.reuseId)
        
        table.pinLeft(to: view.leadingAnchor)
        table.pinRight(to: view.trailingAnchor)
        table.pinTop(to: view.topAnchor)
        table.pinBottom(to: view.bottomAnchor)
    }
    
    // MARK: - Cell Methods
    private func showQuantityInput(for indexPath: IndexPath) {
        func showErrorAlert() {
            let errorAlert = UIAlertController(title: "Invalid Input", message: "Please enter a valid number.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.showQuantityInput(for: indexPath)
            }
            
            errorAlert.addAction(dismissAction)
            present(errorAlert, animated: true, completion: nil)
        }
        
        let alertController = UIAlertController(title: "Enter a Number", message: nil, preferredStyle: .alert)
                
            alertController.addTextField { textField in
                textField.placeholder = "Enter number"
                textField.keyboardType = .numberPad
            }
            
            let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let text = alertController.textFields?.first?.text, let number = Int(text) else {
                    showErrorAlert()
                    return
                }
                
                // Обновляем данные и ячейку
                self?.habitQuantity = String(number)
                self?.table.reloadItems(at: [indexPath])
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc
    private func dismissButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UICollectionViewDelegate
extension AddHabitViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:    Constants.Table.elementsTopIndent,
                            left:   Constants.Table.elementsLeadingIndent,
                            bottom: Constants.Table.elementsBottomIndent,
                            right:  Constants.Table.elementsTrailingIndent)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        
        switch section {
            
        // Полная ширина
        case Constants.Table.titleCellSectionIndex,
             Constants.Table.motivationsCellSectionIndex,
             Constants.Table.regularityCellSectionIndex,
             Constants.Table.dayPartCellSectionIndex,
             Constants.Table.confirmButtonSectionIndex:
            let sideIndent: CGFloat = 36
            let width = collectionView.bounds.width - sideIndent // sideIndent - отступы от краев в сумме
            let height = calculateHeightForHabitTitleCell(indexPath: indexPath)
            return CGSize(width: width, height: height)
            
        // Половина ширины
        case Constants.Table.colorCellSectionIndex,
             Constants.Table.iconCellSectionIndex,
             Constants.Table.quantityCellSectionIndex,
             Constants.Table.measurementCellSectionIndex:
            let sideIndent: CGFloat = 36
            let cellsIndent: CGFloat = 18
            let availableWidth = collectionView.bounds.width - sideIndent - cellsIndent // sideIndent - отступы от краев в сумме, cellsIndent - отступ между ячейками
            
            let numberOfCellsInRow: CGFloat = 2
            let width = availableWidth / numberOfCellsInRow
            let height = calculateHeightForHabitTitleCell(indexPath: indexPath)
            return CGSize(width: width, height: height)
            
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    private func calculateHeightForHabitTitleCell(indexPath: IndexPath) -> CGFloat {
        // Ячейки-заглушки для подсчета высоты
        var dummyCell: UICollectionViewCell
        switch indexPath.section {
        case Constants.Table.titleCellSectionIndex:         dummyCell = HabitTitleCell()
        case Constants.Table.motivationsCellSectionIndex:   dummyCell = HabitMotivationsCell()
        case Constants.Table.colorCellSectionIndex:         dummyCell = HabitColorCell()
        case Constants.Table.iconCellSectionIndex:          dummyCell = HabitIconCell()
        case Constants.Table.quantityCellSectionIndex:      dummyCell = HabitQuantityCell()
        case Constants.Table.measurementCellSectionIndex:   dummyCell = HabitMeasurementCell()
        case Constants.Table.regularityCellSectionIndex:    dummyCell = HabitRegularityCell()
        case Constants.Table.dayPartCellSectionIndex:       dummyCell = HabitDayPartCell()
        case Constants.Table.confirmButtonSectionIndex:     dummyCell = HabitConfirmCreationCell()
        default:                                            dummyCell = UICollectionViewCell()
        }
        
        dummyCell.layoutIfNeeded()
        let calculatedHeight = dummyCell.contentView.systemLayoutSizeFitting(CGSize(width: 0, height: UIView.layoutFittingCompressedSize.height)).height
        return calculatedHeight
    }
}

// MARK: - UICollectionViewDataSource
extension AddHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
       // 1 ячейка в ряду
        case Constants.Table.titleCellSectionIndex,
             Constants.Table.motivationsCellSectionIndex,
             Constants.Table.regularityCellSectionIndex,
             Constants.Table.dayPartCellSectionIndex,
             Constants.Table.confirmButtonSectionIndex:
            return Constants.Table.oneRowInSection
        // 2 ячейки в ряду
        case Constants.Table.colorCellSectionIndex,
             Constants.Table.iconCellSectionIndex,
             Constants.Table.quantityCellSectionIndex,
             Constants.Table.measurementCellSectionIndex:
            return Constants.Table.twoRowsInSection
            
        default:
            return Constants.Table.zeroRowsInSection
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.Table.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section: Int = indexPath.section
        let row: Int = indexPath.row
        
        switch (section, row) {
        
        // habitTitleCell
        case (Constants.Table.titleCellSectionIndex, Constants.Table.titleCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitTitleCell.reuseId, for: indexPath)
            guard let habitTitleCell = cell as? HabitTitleCell else { return cell }
            
            habitTitleCell.configure(with: habitTitle ?? "")
            
            habitTitleCell.onTitleChanged = { [weak self] text in
                self?.habitTitle = text
            }
            
            return habitTitleCell
            
        // habitMotivationsCell
        case (Constants.Table.motivationsCellSectionIndex, Constants.Table.motivationsCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitMotivationsCell.reuseId, for: indexPath)
            guard let habitMotivationsCell = cell as? HabitMotivationsCell else { return cell }
            
            habitMotivationsCell.configure(with: habitMotivations ?? "")
            
            habitMotivationsCell.onMotivationsChanged = { [weak self] text in
                self?.habitMotivations = text
            }
            
            return habitMotivationsCell
            
        // habitColorCell
        case (Constants.Table.colorCellSectionIndex, Constants.Table.colorCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitColorCell.reuseId, for: indexPath)
            guard let habitColorCell = cell as? HabitColorCell else { return cell }
            
            habitColorCell.configure(with: habitColor ?? "")
            
            habitColorCell.onColorChanged = { [weak self] hexColor in
                self?.habitColor = hexColor
            }
            
            return habitColorCell
            
        // habitIconCell
        case (Constants.Table.iconCellSectionIndex, Constants.Table.iconCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitIconCell.reuseId, for: indexPath)
            guard let habitIconCell = cell as? HabitIconCell else { return cell }
            
            habitIconCell.configure(with: habitIcon ?? "")
            
            habitIconCell.onIconChanged = { [weak self] iconName in
                self?.habitIcon = iconName
            }
            
            return habitIconCell
            
        // habitQuantityCell
        case (Constants.Table.quantityCellSectionIndex, Constants.Table.quantityCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitQuantityCell.reuseId, for: indexPath)
            guard let habitQuantityCell = cell as? HabitQuantityCell else { return cell }
            
            habitQuantityCell.onEnterQuantityButtonPressed = {
                self.showQuantityInput(for: indexPath)
            }
            
            habitQuantityCell.configure(with: habitQuantity ?? "")
            
            return habitQuantityCell
            
        // habitMeasurementCell
        case (Constants.Table.measurementCellSectionIndex, Constants.Table.measurementCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitMeasurementCell.reuseId, for: indexPath)
            guard let habitMeasurementCell = cell as? HabitMeasurementCell else { return cell }
            
            habitMeasurementCell.configure(with: habitMeasurementType ?? "")
            
            habitMeasurementCell.onMeasurementChanged = { [weak self] measurement in
                self?.habitMeasurementType = measurement
            }
            
            return habitMeasurementCell
            
        // habitRegularityCell
        case (Constants.Table.regularityCellSectionIndex, Constants.Table.regularityCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitRegularityCell.reuseId, for: indexPath)
            guard let habitRegularityCell = cell as? HabitRegularityCell else { return cell }
            
            habitRegularityCell.configure(with: habitPeriod ?? "")
            
            habitRegularityCell.onRegularityChanged = { [weak self] regularity in
                self?.habitPeriod = regularity
            }
            
            return habitRegularityCell
            
        // habitDayPartCell
        case (Constants.Table.dayPartCellSectionIndex, Constants.Table.dayPartCellRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitDayPartCell.reuseId, for: indexPath)
            guard let habitDayPartCell = cell as? HabitDayPartCell else { return cell }
            
            habitDayPartCell.configure(with: habitDayPart ?? "")
            
            habitDayPartCell.onDayPartChanged = { [weak self] dayPart in
                self?.habitDayPart = dayPart
            }
            
            return habitDayPartCell
            
        // habitConfirmHabitCreationCell
        case (Constants.Table.confirmButtonSectionIndex, Constants.Table.confirmButtonRowIndex):
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitConfirmCreationCell.reuseId, for: indexPath)
            guard let habitConfirmHabitCreationCell = cell as? HabitConfirmCreationCell else { return cell }
            
            // Изменяем текст кнопки в зависимости от того, меняем или создаем привычку
            if habit != nil {
                habitConfirmHabitCreationCell.configure(isNew: false)
            } else {
                habitConfirmHabitCreationCell.configure(isNew: true)
            }
            
            habitConfirmHabitCreationCell.onCreateHabitButtonPressed = {
                if self.habitTitle != "" {
                    let currentDate = Date()
                    let newHabit = HabitModel(creationDate: currentDate,
                                              title: self.habitTitle,
                                              motivations: self.habitMotivations,
                                              color: self.habitColor,
                                              icon: self.habitIcon,
                                              quantity: self.habitQuantity,
                                              currentQuantity: self.habitCurrentQuantity,
                                              measurement: self.habitMeasurementType,
                                              regularity: self.habitPeriod,
                                              dayPart: self.habitDayPart)
                    
                    // Если привычка пришла извне - изменяем ее, иначе создаем новую
                    if let habit = self.habit {
                        habit.updateHabit(newHabit: newHabit)
                    } else {
                        CoreManager.shared.addNewHabit(newHabit)
                    }
                    
                    NotificationCenter.default.post(name: .habitAdded, object: nil)
                    
                    self.dismiss(animated: true)
                }
            }
            
            return habitConfirmHabitCreationCell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section: Int = indexPath.section
        let row: Int = indexPath.row
        if section == Constants.Table.quantityCellSectionIndex && row == Constants.Table.quantityCellRowIndex {
            showQuantityInput(for: indexPath)
        }
    }
}

