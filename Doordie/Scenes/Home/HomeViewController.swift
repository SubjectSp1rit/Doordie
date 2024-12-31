//
//  HomeViewController.swift
//  Doordie
//
//  Created by Arseniy on 27.12.2024.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum Table {
            static let bgColor: UIColor = .clear
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let numberOfSections: Int = 3
            static let numberOfRowsInSection: Int = 1
            static let indentBetweenSections: CGFloat = 20
            
            static let headerCellHeight: CGFloat = 60
            static let horizontalDateCollectionCellHeight: CGFloat = 100
            static let dayPartSelectorCell: CGFloat = 40
        }
        
        enum NavigationBar {
            static let maxBlurAlpha: CGFloat = 1.0
            static let minBlurAlpha: CGFloat = 0.0
            static let fadeThreshold: CGFloat = 10 // Высота прокрутки, после которой размытие максимально
            static let blurColor: UIColor = UIColor(hex: "2A50AB").withAlphaComponent(0.2)
            static let height: CGFloat = 100
        }
        
        enum NavBarCenteredTitle {
            static let maxBlurAlpha: CGFloat = 0.8
            static let minBlurAlpha: CGFloat = 0.0
            static let fadeThreshold: CGFloat = 10 // Высота прокрутки, после которой размытие максимально
            static let alignment: NSTextAlignment = .center
            static let fontSize: CGFloat = 18
            static let fontWeight: UIFont.Weight = .bold
            static let color: UIColor = .white
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let table: UITableView = UITableView()
    private let navBarCenteredTitle: UILabel = UILabel()
    
    // MARK: - Variables
    private var interactor: HomeBusinessLogic
    private var blurredNavBarView: UIVisualEffectView?
    
    // MARK: - Lifecycle
    init(interactor: HomeBusinessLogic) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        navBarCenteredTitle.alpha = Constants.NavBarCenteredTitle.minBlurAlpha
        blurredNavBarView?.alpha = Constants.NavigationBar.minBlurAlpha
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureNavBar()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureTable()
        configureNavBarCenteredTitle()
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
    
    private func configureNavBarCenteredTitle() {
        navBarCenteredTitle.text = "December 31"
        navBarCenteredTitle.textAlignment = Constants.NavBarCenteredTitle.alignment
        navBarCenteredTitle.font = UIFont.systemFont(ofSize: Constants.NavBarCenteredTitle.fontSize, weight: Constants.NavBarCenteredTitle.fontWeight)
        navBarCenteredTitle.textColor = Constants.NavBarCenteredTitle.color
        navBarCenteredTitle.sizeToFit()
        
        navigationItem.titleView = navBarCenteredTitle
    }

    private func configureNavBar() {
        // Создаём кастомный цвет размытия
        let blurredNavBarView = createCustomBlurView(with: Constants.NavigationBar.blurColor)
        view.addSubview(blurredNavBarView)
        
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let totalNavBarHeight = statusBarHeight + navigationBarHeight
        
        blurredNavBarView.pinTop(to: view.topAnchor)
        blurredNavBarView.pinLeft(to: view.leadingAnchor)
        blurredNavBarView.pinRight(to: view.trailingAnchor)
        blurredNavBarView.setHeight(totalNavBarHeight)

        // Сохранение ссылки на размытие
        self.blurredNavBarView = blurredNavBarView

        // Удаление стандартного фона у навбара
        guard let navigationBar = navigationController?.navigationBar else { return }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
    
    private func createCustomBlurView(with color: UIColor) -> UIVisualEffectView {
        // Стандартное размытие
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Цветной полупрозрачный слой поверх размытия
        let colorOverlay = UIView()
        colorOverlay.backgroundColor = color // Прозрачность слоя
        
        // Добавление цветного слоя поверх основного слоя размытия
        blurEffectView.contentView.addSubview(colorOverlay)
        colorOverlay.pin(to: blurEffectView.contentView)
        
        return blurEffectView
    }
    
    private func configureTable() {
        view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = Constants.Table.separatorStyle
        table.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseId)
        table.register(HorizontalDateCollectionCell.self, forCellReuseIdentifier: HorizontalDateCollectionCell.reuseId)
        table.register(DayPartSelectorCell.self, forCellReuseIdentifier: DayPartSelectorCell.reuseId)
        table.layer.masksToBounds = false
        
        table.pinTop(to: view.topAnchor)
        table.pinBottom(to: view.bottomAnchor)
        table.pinHorizontal(to: view)
        
        table.backgroundColor = Constants.Table.bgColor
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionIndex = indexPath.section
        switch sectionIndex {
        case 0: return Constants.Table.headerCellHeight
        case 1: return Constants.Table.horizontalDateCollectionCellHeight
        case 2: return Constants.Table.dayPartSelectorCell
        default: return UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.Table.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.Table.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.Table.indentBetweenSections
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView: UIView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIndex = indexPath.section
        if sectionIndex == 0 {          // HeaderCell
            let cell = table.dequeueReusableCell(withIdentifier: HeaderCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let headerCell = cell as? HeaderCell else { return cell }
            
            headerCell.configure()
            
            return headerCell
        } else if sectionIndex == 1 {   // HorizontalDateCollectionCell
            let cell = table.dequeueReusableCell(withIdentifier: HorizontalDateCollectionCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let horizontalDateCollectionCell = cell as? HorizontalDateCollectionCell else { return cell }
            
            return horizontalDateCollectionCell
        } else {                        // dayPartSelectorCell
            let cell = table.dequeueReusableCell(withIdentifier: DayPartSelectorCell.reuseId, for: indexPath)
            guard let dayPartSelectorCell = cell as? DayPartSelectorCell else { return cell }
            
            return dayPartSelectorCell
        }
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let blurredNavBarView = blurredNavBarView else { return }
        
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let totalNavBarHeight = statusBarHeight + navigationBarHeight
        
        let offset = scrollView.contentOffset.y + totalNavBarHeight
        
        let blurAlpha = max(Constants.NavigationBar.minBlurAlpha,
                        min(Constants.NavigationBar.maxBlurAlpha, offset / Constants.NavigationBar.fadeThreshold))
        let titleAlpha = max(Constants.NavBarCenteredTitle.minBlurAlpha,
                             min(Constants.NavBarCenteredTitle.maxBlurAlpha, offset / Constants.NavBarCenteredTitle.fadeThreshold))
        blurredNavBarView.alpha = blurAlpha
        navBarCenteredTitle.alpha = titleAlpha
    }
}
