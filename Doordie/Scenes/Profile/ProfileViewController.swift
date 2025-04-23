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
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.85
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
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
        
        enum RefreshControl {
            static let tintColor: UIColor = .systemGray
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
            static let numberOfShimmerFriendCells: Int = 10
            static let numberOfStatsCells: Int = 1
        }
    }
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let wrap: UIView = UIView()
    private let profileImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let menuSelectorTable: UICollectionView
    private let table: UITableView = UITableView()
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Properties
    private var interactor: (ProfileBusinessLogic & FriendsStorage & HabitsAnalyticsStorage)
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    private var selectedDayPart: String = "Stats"
    private var isFriendsLoaded: Bool = false
    private var isHabitsLoaded: Bool = false
    
    // MARK: - Lifecycle
    init(interactor: (ProfileBusinessLogic & FriendsStorage & HabitsAnalyticsStorage)) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAllFriends()
        fetchAllHabits()
    }
    
    // MARK: - Methods
    func displayFetchedFriends(_ viewModel: ProfileModels.FetchAllFriends.ViewModel) {
        refreshControl.endRefreshing()
        isFriendsLoaded = true
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func retryFetchAllFriends(_ viewModel: ProfileModels.FetchAllFriends.ViewModel) {
        fetchAllFriends()
    }
    
    func displayUpdatedHabits(_ viewModel: ProfileModels.FetchAllHabitsAnalytics.ViewModel) {
        refreshControl.endRefreshing()
        isHabitsLoaded = true
        table.reloadData()
        table.visibleCells.forEach { cell in // Обновляем вложенную таблицу с датами
            if let habitAnalyticsCell = cell as? HabitAnalyticsCell {
                habitAnalyticsCell.reloadData()
                habitAnalyticsCell.scrollToCenter()
            }
            if let habitPerformanceCell = cell as? HabitPerformanceCell {
                habitPerformanceCell.scrollToCenter()
            }
        }
    }
    
    func retryFetchHabits(_ viewModel: ProfileModels.FetchAllHabitsAnalytics.ViewModel) {
        fetchAllHabits()
    }
    
    // MARK: - Private Methods
    private func fetchAllFriends() {
        isFriendsLoaded = false
        interactor.fetchAllFriends(ProfileModels.FetchAllFriends.Request())
    }
    
    private func fetchAllHabits() {
        isHabitsLoaded = false
        interactor.fetchAllHabits(ProfileModels.FetchAllHabitsAnalytics.Request())
    }
    
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
        configureRefreshControl()
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
        wrap.layer.shadowColor = Constants.Wrap.shadowColor
        wrap.layer.shadowOpacity = Constants.Wrap.shadowOpacity
        wrap.layer.shadowOffset = CGSize(width: Constants.Wrap.shadowOffsetX, height: Constants.Wrap.shadowOffsetY)
        wrap.layer.shadowRadius = Constants.Wrap.shadowRadius
        wrap.layer.masksToBounds = false
        
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
        table.layer.masksToBounds = false
        table.alwaysBounceVertical = true
        table.refreshControl = refreshControl
        table.register(FriendCell.self, forCellReuseIdentifier: FriendCell.reuseId)
        table.register(AddFriendCell.self, forCellReuseIdentifier: AddFriendCell.reuseId)
        table.register(ShimmerFriendCell.self, forCellReuseIdentifier: ShimmerFriendCell.reuseId)
        table.register(HabitPerformanceCell.self, forCellReuseIdentifier: HabitPerformanceCell.reuseId)
        
        table.pinCenterX(to: wrap.centerXAnchor)
        table.pinLeft(to: wrap.leadingAnchor, Constants.Table.leadingIndent)
        table.pinTop(to: menuSelectorTable.bottomAnchor, Constants.Table.topIndent)
        table.pinBottom(to: wrap.bottomAnchor)
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = Constants.RefreshControl.tintColor
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc private func refreshData() {
        isFriendsLoaded = false
        table.reloadData()
        refreshControl.endRefreshing()
        fetchAllFriends()
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedDayPart {
            
        case Constants.MenuSelectorTable.parts[0]: // Stats
            return Constants.Table.numberOfStatsCells
            
        case Constants.MenuSelectorTable.parts[1]: // Friends
            if isFriendsLoaded {
                return interactor.friends.count + 1
            } else {
                return Constants.Table.numberOfShimmerFriendCells
            }
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedDayPart {
            
        case Constants.MenuSelectorTable.parts[0]: // Stats
            let row = indexPath.row
            
            switch row {
            case 0:
                let cell = table.dequeueReusableCell(withIdentifier: HabitPerformanceCell.reuseId, for: indexPath)
                guard let habitPerformanceCell = cell as? HabitPerformanceCell else { return cell }
                habitPerformanceCell.selectionStyle = .none
                
                habitPerformanceCell.configure(with: interactor.habitsAnalytics)
                
                return habitPerformanceCell
                
            default:
                return UITableViewCell()
            }
            
        case Constants.MenuSelectorTable.parts[1]: // Friends
            if isFriendsLoaded == false { // Пока друзья не загружены, показываем шимер
                let cell = table.dequeueReusableCell(withIdentifier: ShimmerFriendCell.reuseId, for: indexPath)
                guard let shimmerFriendCell = cell as? ShimmerFriendCell else { return cell }
                shimmerFriendCell.selectionStyle = .none
                
                shimmerFriendCell.startShimmer()
                
                return shimmerFriendCell
            }
            
            switch indexPath.row {
                
            case 0: // ProfileAddFriendCell
                let cell = table.dequeueReusableCell(withIdentifier: AddFriendCell.reuseId, for: indexPath)
                guard let profileAddFriendCell = cell as? AddFriendCell else { return cell }
                profileAddFriendCell.selectionStyle = .none
                
                return profileAddFriendCell
                
            default: // ProfileFriendCell
                let cell = table.dequeueReusableCell(withIdentifier: FriendCell.reuseId, for: indexPath)
                guard let profileFriendCell = cell as? FriendCell else { return cell }
                profileFriendCell.selectionStyle = .none
                
                profileFriendCell.delegate = self
                
                let friendData = interactor.friends[indexPath.row - 1]
                profileFriendCell.configure(with: friendData)
                
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
                let friend = interactor.friends[indexPath.row - 1]
                let email = friend.email ?? ""
                let name = friend.name ?? "Unkown name"
                interactor.routeToFriendProfileScreen(ProfileModels.RouteToFriendProfileScreen.Request(email: email, name: name))
                return
            }
            
        default:
            return
        }
    }
}

// MARK: - ProfileCellDelegate
extension ProfileViewController: ProfileCellDelegate {
    func profileCellDidTriggerDelete(_ cell: FriendCell) {
        if let indexPath = table.indexPath(for: cell) {
            var friendsCopy = interactor.friends
            
            // отправляем запрос в бек на удаление друга
            guard let friendEmail = interactor.friends[indexPath.row - 1].email else { return }
            interactor.deleteFriend(ProfileModels.DeleteFriend.Request(email: friendEmail))
            
            friendsCopy.remove(at: indexPath.row - 1)
            interactor.friends = friendsCopy
            
            self.table.performBatchUpdates({
                self.table.deleteRows(at: [indexPath], with: .left)
            }, completion: nil)
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

