//
//  AnalyticsViewController.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import UIKit

final class AnalyticsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBarCenteredTitle {
            static let title: String = "Analytics"
            static let alignment: NSTextAlignment = .center
            static let color: UIColor = .white
            static let fontSize: CGFloat = 18
            static let fontWeight: UIFont.Weight = .semibold
        }
        
        enum Table {
            static let bgColor: UIColor = .clear
            static let separatorStyle: UITableViewCell.SeparatorStyle = .none
            static let numberOfSections: Int = 2
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 12
        }
    }
    
    // UI Components
    private let background: UIImageView = UIImageView()
    private let navBarCenteredTitle: UILabel = UILabel()
    private let table: UITableView = UITableView()
    
    // MARK: - Properties
    private var interactor: (AnalyticsBusinessLogic & HabitsAnalyticsStorage)
    private var isHabitsLoaded: Bool = false
    
    // MARK: - Lifecycle
    init(interactor: (AnalyticsBusinessLogic & HabitsAnalyticsStorage)) {
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
        fetchAllHabits()
        view.layoutIfNeeded() // Нужна для вызова layoutSubviews() у tableView
        table.reloadData() // Обновляем таблицу, чтобы мерцающие ячейки снова запустили анимацию
    }
    
    // MARK: - Methods
    func displayUpdatedHabits(_ viewModel: HomeModels.FetchAllHabits.ViewModel) {
        isHabitsLoaded = true
        table.reloadData()
    }
    
    // MARK: - Private Methods
    private func fetchAllHabits() {
        isHabitsLoaded = false
        table.reloadData()
        interactor.fetchAllHabits(AnalyticsModels.FetchAllHabitsAnalytics.Request())
    }
    
    private func configureUI() {
        configureBackground()
        configureNavBar()
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
    
    private func configureTable() {
        view.addSubview(table)
        
        table.backgroundColor = Constants.Table.bgColor
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = Constants.Table.separatorStyle
        table.layer.masksToBounds = true
        table.alwaysBounceVertical = true
        table.register(HabitAnalyticsCell.self, forCellReuseIdentifier: HabitAnalyticsCell.reuseId)
        
        table.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        table.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.Table.leadingIndent)
        table.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.Table.topIndent)
        table.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

// MARK: - UITableViewDelegate
extension AnalyticsViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension AnalyticsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.Table.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case 0:
            return 0
            
        case 1:
            return interactor.habitsAnalytics.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
            
        case 0:
            return UITableViewCell()
            
        case 1:
            let cell = table.dequeueReusableCell(withIdentifier: HabitAnalyticsCell.reuseId, for: indexPath)
            guard let habitAnalyticsCell = cell as? HabitAnalyticsCell else { return cell }
            habitAnalyticsCell.selectionStyle = .none
            
            habitAnalyticsCell.configure(with: interactor.habitsAnalytics[indexPath.row])
            
            return habitAnalyticsCell
            
        default:
            return UITableViewCell()
        }
    }
}
