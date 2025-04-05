//
//  ProfileViewController.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Profile"
            static let tintColor: UIColor = .white
        }
        
        enum Wrap {
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 100
        }
        
        enum ProfileImage {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let cornerRadius: CGFloat = 75
            static let imageSide: CGFloat = 150
        }
        
        enum NameLabel {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
            static let fontSize: CGFloat = 48
            static let fontWeigth: UIFont.Weight = .semibold
            static let topIndent: CGFloat = 12
        }
        
        enum Layout {
            static let cellCount: CGFloat = 2
            static let cellWidth: CGFloat = 100
            static let totalCellsWidth = cellWidth * cellCount
            static let scrollDirection: UICollectionView.ScrollDirection = .horizontal
            static let width: CGFloat = 100
            static let height: CGFloat = 40
            static let minimumLineSpacing: CGFloat = 0
            static let minimumInteritemSpacing: CGFloat = 0
        }
        
        enum MenuSelectorTable {
            static let parts: [String] = ["Stats", "Friends"]
            static let bgColor: UIColor = .clear
            static let elementsLeadingIndent: CGFloat = 18
            static let elementsTrailingIndent: CGFloat = 18
            static let elementsTopIndent: CGFloat = 0
            static let elementsBottomIndent: CGFloat = 0
            static let leadingIndent: CGFloat = 12
            static let topIndent: CGFloat = 12
        }
        
        enum Table {
            static let bgColor: UIColor = .clear
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let numberOfSections: Int = 1
            static let numberOfRowsInSection: Int = 3
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 12
        }
    }
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let wrap: UIView = UIView()
    private let profileImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let menuSelectorTable: UICollectionView
    private let table: UITableView = UITableView()
    
    // MARK: - Properties
    private var interactor: ProfileBusinessLogic
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    private var selectedDayPart: String = "Stats"
    
    // MARK: - Lifecycle
    init(interactor: ProfileBusinessLogic) {
        self.interactor = interactor
        self.menuSelectorTable = ProfileViewController.createCollectionView()
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
        layout.itemSize = CGSize(width: Constants.Layout.cellWidth, height: Constants.Layout.height)
        layout.minimumLineSpacing = Constants.Layout.minimumLineSpacing
        layout.minimumInteritemSpacing = Constants.Layout.minimumInteritemSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.layer.masksToBounds = false
        collectionView.contentInsetAdjustmentBehavior = .always
        return collectionView
    }
    
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureWrap()
        configureProfileImage()
        configureNameLabel()
        configureMenuSelectorTable()
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
        navigationItem.title = Constants.NavBar.title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.NavBar.tintColor]
    }
    
    private func configureWrap() {
        view.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrap.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        wrap.pinCenterX(to: view.centerXAnchor)
        wrap.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinBottom(to: view.bottomAnchor)
        wrap.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.Wrap.topIndent)
    }
    
    private func configureProfileImage() {
        view.addSubview(profileImage)
        
        profileImage.contentMode = Constants.ProfileImage.contentMode
        profileImage.layer.cornerRadius = Constants.ProfileImage.cornerRadius
        profileImage.clipsToBounds = true
        profileImage.setWidth(Constants.ProfileImage.imageSide)
        profileImage.setHeight(Constants.ProfileImage.imageSide)
        
        // temp
        profileImage.image = UIImage(named: "profileImage")
        
        profileImage.pinCenterX(to: wrap.centerXAnchor)
        profileImage.pinCenterY(to: wrap.topAnchor)
    }
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        
        let name = UserDefaultsManager.shared.name ?? "User"
        nameLabel.text = name
        nameLabel.textAlignment = Constants.NameLabel.textAlignment
        nameLabel.font = UIFont.systemFont(ofSize: Constants.NameLabel.fontSize, weight: Constants.NameLabel.fontWeigth)
        nameLabel.textColor = Constants.NameLabel.textColor
        
        nameLabel.pinCenterX(to: wrap.centerXAnchor)
        nameLabel.pinTop(to: profileImage.bottomAnchor, Constants.NameLabel.topIndent)
    }
    
    private func configureMenuSelectorTable() {
        view.addSubview(menuSelectorTable)
        
        menuSelectorTable.showsHorizontalScrollIndicator = false
        menuSelectorTable.backgroundColor = Constants.MenuSelectorTable.bgColor
        menuSelectorTable.delegate = self
        menuSelectorTable.dataSource = self
        menuSelectorTable.register(MenuSelectorCell.self, forCellWithReuseIdentifier: MenuSelectorCell.reuseId)
        
        menuSelectorTable.pinLeft(to: wrap.leadingAnchor, Constants.MenuSelectorTable.leadingIndent)
        menuSelectorTable.pinCenterX(to: wrap.centerXAnchor)
        menuSelectorTable.pinTop(to: nameLabel.bottomAnchor, Constants.MenuSelectorTable.topIndent)
        menuSelectorTable.setHeight(40)
    }
    
    private func configureTable() {
        view.addSubview(table)
        
        table.backgroundColor = Constants.Table.bgColor
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = Constants.Table.separatorStyle
        table.layer.masksToBounds = true
        table.alwaysBounceVertical = true
        table.register(ProfileFriendCell.self, forCellReuseIdentifier: ProfileFriendCell.reuseId)
        table.register(ProfileAddFriendCell.self, forCellReuseIdentifier: ProfileAddFriendCell.reuseId)
        
        table.pinCenterX(to: wrap.centerXAnchor)
        table.pinLeft(to: wrap.leadingAnchor, Constants.Table.leadingIndent)
        table.pinTop(to: menuSelectorTable.bottomAnchor, Constants.Table.topIndent)
        table.pinBottom(to: wrap.bottomAnchor)
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedDayPart {
            
        case Constants.MenuSelectorTable.parts[0]: // Stats
            return 0
            
        case Constants.MenuSelectorTable.parts[1]: // Friends
            return 3
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedDayPart {
            
        case Constants.MenuSelectorTable.parts[0]: // Stats
            return UITableViewCell() // Пока ничего не возвращаем
            
        case Constants.MenuSelectorTable.parts[1]: // Friends
            switch indexPath.row {
                
            case 0: // ProfileAddFriendCell
                let cell = table.dequeueReusableCell(withIdentifier: ProfileAddFriendCell.reuseId, for: indexPath)
                guard let profileAddFriendCell = cell as? ProfileAddFriendCell else { return cell }
                profileAddFriendCell.selectionStyle = .none
                
                return profileAddFriendCell
                
            default: // ProfileFriendCell
                let cell = table.dequeueReusableCell(withIdentifier: ProfileFriendCell.reuseId, for: indexPath)
                guard let profileFriendCell = cell as? ProfileFriendCell else { return cell }
                profileFriendCell.selectionStyle = .none
                
                return profileFriendCell
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectedDayPart {
            
        case Constants.MenuSelectorTable.parts[0]: // Stats
            return // Пока ничего не делаем
        
        case Constants.MenuSelectorTable.parts[1]: // Friends
            switch indexPath.row {
                
            case 0: // ProfileAddFriendCell
                interactor.routeToAddFriendScreen(ProfileModels.RouteToAddFriendScreen.Request())
                return
                
            default: // ProfileFriendCell
                // route to friend profile screen
                return
            }
            
        default:
            return
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalWidth = collectionView.bounds.width
        let cellsWidth = Constants.Layout.totalCellsWidth
        let sideInset = (totalWidth - cellsWidth) / 2
        
        return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.MenuSelectorTable.parts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuSelectorTable.dequeueReusableCell(withReuseIdentifier: MenuSelectorCell.reuseId, for: indexPath)
        guard let menuSelectorCell = cell as? MenuSelectorCell else { return cell }
        
        menuSelectorCell.configure(with: Constants.MenuSelectorTable.parts[indexPath.row])
        
        // Устанавливаем цвет ячейки в зависимости от того, выбрана ли она
        if selectedIndexPath == indexPath {
            menuSelectorCell.didSelect()
        } else {
            menuSelectorCell.unselect()
        }
        
        return menuSelectorCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        
        // Получаем текущее значение дня
        let selectedPart = Constants.MenuSelectorTable.parts[indexPath.row]
        
        self.selectedDayPart = selectedPart
        
        self.table.reloadSections(IndexSet(integer: 0), with: .automatic)
        
        // Обновляем текущую и предыдущую ячейки
        var indexPathsToReload = [indexPath]
        if let previousIndexPath = previousIndexPath {
            indexPathsToReload.append(previousIndexPath)
        }
        collectionView.reloadItems(at: indexPathsToReload)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

