//
//  SettingsViewController.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBarCenteredTitle {
            static let title: String = "Settings"
            static let alignment: NSTextAlignment = .center
            static let color: UIColor = .white
            static let fontSize: CGFloat = 18
            static let fontWeight: UIFont.Weight = .semibold
        }
        
        enum NavBarNotificationBtn {
            static let tintColor: UIColor = .white
            static let imageName: String = "bell.fill"
        }
        
        enum Table {
            static let bgColor: UIColor = .clear
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let numberOfSections: Int = 4
            static let numberOfRowsInSection0: Int = 1
            static let numberOfRowsInSection1: Int = 2
            static let numberOfRowsInSection2: Int = 4
            static let numberOfRowsInSection3: Int = 1
            static let indentBetweenSections: CGFloat = 20
        }
        
        enum Utilities {
            static let telegramChannelLink: String = "doordie_app"
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let navBarCenteredTitle: UILabel = UILabel()
    private let navBarNotificationBtn: UIButton = UIButton(type: .system)
    private let table: UITableView = UITableView()
    
    // MARK: - Variables
    private var interactor: SettingsBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: SettingsBusinessLogic) {
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
        configureNavBarNotificationBtn()
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
    
    private func configureNavBar() {
        navBarCenteredTitle.text = Constants.NavBarCenteredTitle.title
        navBarCenteredTitle.textAlignment = Constants.NavBarCenteredTitle.alignment
        navBarCenteredTitle.font = UIFont.systemFont(ofSize: Constants.NavBarCenteredTitle.fontSize, weight: Constants.NavBarCenteredTitle.fontWeight)
        navBarCenteredTitle.textColor = Constants.NavBarCenteredTitle.color
        
        navigationItem.titleView = navBarCenteredTitle
    }
    
    private func configureNavBarNotificationBtn() {
        navBarNotificationBtn.setImage(UIImage(systemName: Constants.NavBarNotificationBtn.imageName), for: .normal)
        navBarNotificationBtn.tintColor = Constants.NavBarNotificationBtn.tintColor
        navBarNotificationBtn.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: navBarNotificationBtn)
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func configureTable() {
        view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = Constants.Table.separatorStyle
        
        table.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseId)
        table.register(AppLanguageCell.self, forCellReuseIdentifier: AppLanguageCell.reuseId)
        table.register(AppThemeCell.self, forCellReuseIdentifier: AppThemeCell.reuseId)
        table.register(HelpCell.self, forCellReuseIdentifier: HelpCell.reuseId)
        table.register(TermsOfUseCell.self, forCellReuseIdentifier: TermsOfUseCell.reuseId)
        table.register(AppInfoCell.self, forCellReuseIdentifier: AppInfoCell.reuseId)
        table.register(TelegramLinkCell.self, forCellReuseIdentifier: TelegramLinkCell.reuseId)
        table.register(LogoutCell.self, forCellReuseIdentifier: LogoutCell.reuseId)
        
        table.pinTop(to: view.topAnchor)
        table.pinBottom(to: view.bottomAnchor)
        table.pinLeft(to: view.leadingAnchor)
        table.pinRight(to: view.trailingAnchor)
        
        table.backgroundColor = Constants.Table.bgColor
    }
    
    // MARK: - Actions
    @objc
    private func notificationButtonPressed() {
        print("NOTIFICATION SCREEN")
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.Table.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case 0: return Constants.Table.numberOfRowsInSection0
            
        case 1: return Constants.Table.numberOfRowsInSection1
            
        case 2: return Constants.Table.numberOfRowsInSection2
            
        case 3: return Constants.Table.numberOfRowsInSection3
            
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section, row = indexPath.row
        switch (section, row) {
            
        // Profile Cell
        case (0, 0):
            let cell = table.dequeueReusableCell(withIdentifier: ProfileCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let profileCell = cell as? ProfileCell else { return cell }
            
            profileCell.configure()
            
            return profileCell
            
        // AppLanguageCell
        case (1, 0):
            let cell = table.dequeueReusableCell(withIdentifier: AppLanguageCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let appLanguageCell = cell as? AppLanguageCell else { return cell }
            
            appLanguageCell.configure()
            
            return appLanguageCell
            
        // AppThemeCell
        case (1, 1):
            let cell = table.dequeueReusableCell(withIdentifier: AppThemeCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let appThemeCell = cell as? AppThemeCell else { return cell }
            
            appThemeCell.configure()
            
            return appThemeCell
            
        // HelpCell
        case (2, 0):
            let cell = table.dequeueReusableCell(withIdentifier: HelpCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let helpCell = cell as? HelpCell else { return cell }
            
            return helpCell
            
        // TermsOfUseCell
        case (2, 1):
            let cell = table.dequeueReusableCell(withIdentifier: TermsOfUseCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let termsOfUseCell = cell as? TermsOfUseCell else { return cell }
            
            return termsOfUseCell
            
        // AppInfoCell
        case (2, 2):
            let cell = table.dequeueReusableCell(withIdentifier: AppInfoCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let appInfoCell = cell as? AppInfoCell else { return cell }
            
            return appInfoCell
            
        // TelegramLinkCell
        case (2, 3):
            let cell = table.dequeueReusableCell(withIdentifier: TelegramLinkCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let telegramLinkCell = cell as? TelegramLinkCell else { return cell }
            
            return telegramLinkCell
            
        // LogoutCell
        case (3, 0):
            let cell = table.dequeueReusableCell(withIdentifier: LogoutCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let logoutCell = cell as? LogoutCell else { return cell }
            
            return logoutCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.Table.indentBetweenSections
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView: UIView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        switch (section, row) {
            
        // ProfileCell
        case (0, 0):
            interactor.routeToProfileScreen(SettingsModels.RouteToProfileScreen.Request())
            
        // TelegramLinkCell
        case (2, 3):
            interactor.openTelegram(SettingsModels.OpenTelegram.Request(link: Constants.Utilities.telegramChannelLink))
        
        // LogoutCell
        case (3, 0):
            interactor.showLogoutAlert(SettingsModels.ShowLogoutAlert.Request())
            
        default:
            return
        }
    }
}
