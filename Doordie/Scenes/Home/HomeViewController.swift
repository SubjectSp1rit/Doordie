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
        // UI
        static let bgImageName: String = "ultramarineBackground"
        
        // table
        static let tableBgColor: UIColor = .clear
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
        
        background.image = UIImage(named: "ultramarineBackground")
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
        table.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseId)
        
        table.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        table.pinBottom(to: view.bottomAnchor)
        table.pinHorizontal(to: view)
        
        table.backgroundColor = Constants.tableBgColor
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: HeaderCell.reuseId, for: indexPath)
        cell.selectionStyle = .none
        guard let headerCell = cell as? HeaderCell else { return cell }
        
        return headerCell
    }
    
    
}
