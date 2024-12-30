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
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let table: UITableView = UITableView()
    
    // MARK: - Variables
    private var interactor: HomeBusinessLogic
    
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
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureTable()
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
    
    private func configureTable() {
        view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = Constants.Table.separatorStyle
        table.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseId)
        table.register(HorizontalDateCollectionCell.self, forCellReuseIdentifier: HorizontalDateCollectionCell.reuseId)
        table.register(DayPartSelectorCell.self, forCellReuseIdentifier: DayPartSelectorCell.reuseId)
        table.layer.masksToBounds = false
        
        table.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
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
