//
//  FriendsViewController.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

final class FriendsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBarCenteredTitle {
            static let title: String = "Friends"
            static let alignment: NSTextAlignment = .center
            static let color: UIColor = .white
            static let fontSize: CGFloat = 18
            static let fontWeight: UIFont.Weight = .semibold
        }
        
        enum FriendTable {
            static let bgColor: UIColor = .clear
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let numberOfSections: Int = 1
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 12
            static let numberOfShimmerFriendCells: Int = 10
        }
        
        enum RefreshControl {
            static let tintColor: UIColor = .systemGray
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let navBarCenteredTitle: UILabel = UILabel()
    private let friendTable: UITableView = UITableView()
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Variables
    private var interactor: (FriendsBusinessLogic & FriendsStorage)
    private var isFriendsLoaded: Bool = false
    
    // MARK: - Lifecycle
    init(interactor: (FriendsBusinessLogic & FriendsStorage)) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAllFriends()
    }
    
    // MARK: - Methods
    func displayFetchedFriends(_ viewModel: FriendsModels.FetchAllFriends.ViewModel) {
        refreshControl.endRefreshing()
        isFriendsLoaded = true
        DispatchQueue.main.async {
            self.friendTable.reloadData()
        }
    }
    
    func retryFetchAllFriends(_ viewModel: FriendsModels.FetchAllFriends.ViewModel) {
        fetchAllFriends()
    }
    
    // MARK: - Private Methods
    private func fetchAllFriends() {
        isFriendsLoaded = false
        interactor.fetchAllFriends(FriendsModels.FetchAllFriends.Request())
    }
    
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureFriendTable()
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
        navBarCenteredTitle.text = Constants.NavBarCenteredTitle.title
        navBarCenteredTitle.textAlignment = Constants.NavBarCenteredTitle.alignment
        navBarCenteredTitle.font = UIFont.systemFont(ofSize: Constants.NavBarCenteredTitle.fontSize, weight: Constants.NavBarCenteredTitle.fontWeight)
        navBarCenteredTitle.textColor = Constants.NavBarCenteredTitle.color
        
        navigationItem.titleView = navBarCenteredTitle
    }
    
    private func configureFriendTable() {
        view.addSubview(friendTable)
        
        friendTable.backgroundColor = Constants.FriendTable.bgColor
        friendTable.delegate = self
        friendTable.dataSource = self
        friendTable.separatorStyle = Constants.FriendTable.separatorStyle
        friendTable.layer.masksToBounds = true
        friendTable.alwaysBounceVertical = true
        friendTable.refreshControl = refreshControl
        friendTable.register(FriendCell.self, forCellReuseIdentifier: FriendCell.reuseId)
        friendTable.register(AddFriendCell.self, forCellReuseIdentifier: AddFriendCell.reuseId)
        friendTable.register(ShimmerFriendCell.self, forCellReuseIdentifier: ShimmerFriendCell.reuseId)
        
        friendTable.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        friendTable.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.FriendTable.leadingIndent)
        friendTable.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.FriendTable.topIndent)
        friendTable.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = Constants.RefreshControl.tintColor
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc private func refreshData() {
        isFriendsLoaded = false
        friendTable.reloadData()
        refreshControl.endRefreshing()
        fetchAllFriends()
    }
}

// MARK: - UITableViewDataSource
extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFriendsLoaded == false {
            return Constants.FriendTable.numberOfShimmerFriendCells
        }
        return interactor.friends.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFriendsLoaded == false { // Пока друзья не загрузилиь - показываем шиммер
            let cell = friendTable.dequeueReusableCell(withIdentifier: ShimmerFriendCell.reuseId, for: indexPath)
            guard let shimmerFriendCell = cell as? ShimmerFriendCell else { return cell }
            shimmerFriendCell.selectionStyle = .none
            
            shimmerFriendCell.startShimmer()
            
            return shimmerFriendCell
        }
        
        switch indexPath.row {
            
        case 0: // ProfileAddFriendCell
            let cell = friendTable.dequeueReusableCell(withIdentifier: AddFriendCell.reuseId, for: indexPath)
            guard let profileAddFriendCell = cell as? AddFriendCell else { return cell }
            profileAddFriendCell.selectionStyle = .none
            
            return profileAddFriendCell
            
        default: // Friend Cell
            let cell = friendTable.dequeueReusableCell(withIdentifier: FriendCell.reuseId, for: indexPath)
            guard let profileFriendCell = cell as? FriendCell else { return cell }
            profileFriendCell.selectionStyle = .none
            
            profileFriendCell.delegate = self
            
            let friendData = interactor.friends[indexPath.row - 1]
            profileFriendCell.configure(with: friendData)
            
            return profileFriendCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isFriendsLoaded == true else { return }
    
        switch indexPath.row {
                
        case 0: // ProfileAddFriendCell
            interactor.routeToAddFriendScreen(FriendsModels.RouteToAddFriendScreen.Request())
            return
            
        default: // ProfileFriendCell
            let friend = interactor.friends[indexPath.row - 1]
            let email = friend.email ?? ""
            let name = friend.name ?? "Unkown name"
            interactor.routeToFriendProfileScreen(FriendsModels.RouteToFriendProfileScreen.Request(email: email, name: name))
            return
        }
    }
}

// MARK: - UITableViewDelegate
extension FriendsViewController: UITableViewDelegate { }

// MARK: - ProfileCellDelegate
extension FriendsViewController: ProfileCellDelegate {
    func profileCellDidTriggerDelete(_ cell: FriendCell) {
        if let indexPath = friendTable.indexPath(for: cell) {
            var friendsCopy = interactor.friends
            
            // отправляем запрос в бек на удаление друга
            guard let friendEmail = interactor.friends[indexPath.row - 1].email else { return }
            interactor.deleteFriend(FriendsModels.DeleteFriend.Request(email: friendEmail))
            
            friendsCopy.remove(at: indexPath.row - 1)
            interactor.friends = friendsCopy
            
            self.friendTable.performBatchUpdates({
                self.friendTable.deleteRows(at: [indexPath], with: .left)
            }, completion: nil)
        }
    }
}
