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
            static let bgColor: UIColor = .clear
            static let elementsLeadingIndent: CGFloat = 18
            static let elementsTrailingIndent: CGFloat = 18
            static let elementsTopIndent: CGFloat = 12
            static let elementsBottomIndent: CGFloat = 0
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let navBarCenteredTitle: UILabel = UILabel()
    private let navBarDismissButton: UIButton = UIButton(type: .system)
    private let table: UICollectionView
    
    // MARK: - Variables
    private var interactor: AddHabitBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: AddHabitBusinessLogic) {
        self.interactor = interactor
        self.table = AddHabitViewController.createCollectionView()
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
        
        table.pinLeft(to: view.leadingAnchor)
        table.pinRight(to: view.trailingAnchor)
        table.pinTop(to: view.topAnchor)
        table.pinBottom(to: view.bottomAnchor)
    }
    
    // MARK: - Actions
    @objc
    private func dismissButtonPressed() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension AddHabitViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.Table.elementsTopIndent,
                            left: Constants.Table.elementsLeadingIndent,
                            bottom: Constants.Table.elementsBottomIndent,
                            right: Constants.Table.elementsTrailingIndent)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 {
            // Тип 1: Полная ширина
            let width = collectionView.bounds.width - 36 // С учётом отступов
            let height = calculateHeightForHabitTitleCell(indexPath: indexPath)
            return CGSize(width: width, height: height)
        } else {
            // Тип 2: Половина ширины
            let availableWidth = collectionView.bounds.width - 36 - 18 // Учитываем отступы и межстрочный отступ
            let width = availableWidth / 2
            let height = calculateHeightForHabitTitleCell(indexPath: indexPath)
            return CGSize(width: width, height: height)
        }
    }
    
    private func calculateHeightForHabitTitleCell(indexPath: IndexPath) -> CGFloat {
        var dummyCell: UICollectionViewCell
        switch indexPath.section {
        case 0: dummyCell = HabitTitleCell()
        case 1: dummyCell = HabitMotivationsCell()
        case 2: dummyCell = HabitColorCell()
        default: dummyCell = UICollectionViewCell()
        }
        
        dummyCell.layoutIfNeeded()
        let calculatedHeight = dummyCell.contentView.systemLayoutSizeFitting(CGSize(width: 0, height: UIView.layoutFittingCompressedSize.height)).height
        return calculatedHeight
    }
}

// MARK: - UICollectionViewDataSource
extension AddHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else if section == 2 {
            return 2
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitTitleCell.reuseId, for: indexPath)
            guard let habitTitleCell = cell as? HabitTitleCell else { return cell }
            
            return habitTitleCell
        } else if indexPath.section == 1 {
            let cell = table.dequeueReusableCell(withReuseIdentifier: HabitMotivationsCell.reuseId, for: indexPath)
            guard let habitMotivationsCell = cell as? HabitMotivationsCell else { return cell }
            
            return habitMotivationsCell
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = table.dequeueReusableCell(withReuseIdentifier: HabitColorCell.reuseId, for: indexPath)
                guard let habitColorCell = cell as? HabitColorCell else { return cell }
                
                return habitColorCell
            } else if indexPath.row == 1 {
                let cell = table.dequeueReusableCell(withReuseIdentifier: HabitIconCell.reuseId, for: indexPath)
                guard let habitIconCell = cell as? HabitIconCell else { return cell }
                
                return habitIconCell
            }
        }
        return UICollectionViewCell()
    }
}

