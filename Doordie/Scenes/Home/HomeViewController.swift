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
            static let numberOfSections: Int = 6
            static let numberOfRowsInSection: Int = 1
            static let indentBetweenSections: CGFloat = 20
            static let numberOfShimmerCells: Int = 10
            static let numberOfAddHabitCells: Int = 1
            
            static let headerCellHeight: CGFloat = 60
            static let horizontalDateCollectionCellHeight: CGFloat = 100
            static let dayPartSelectorCellHeight: CGFloat = 40
            static let homeMotivationCellHeight: CGFloat = 100
            static let yourHabitsCellHeight: CGFloat = 40
            static let habitCellHeight: CGFloat = 80
            
            static let headerCellSectionIndex: Int = 0
            static let horizontalDateCollectionCellSectionIndex: Int = 1
            static let dayPartSelectorCellSectionIndex: Int = 2
            static let homeMotivationCellSectionIndex: Int = 3
            static let yourHabitsCellSectionIndex: Int = 4
            static let habitCellSectionIndex: Int = 5
        }
        
        enum RefreshControl {
            static let tintColor: UIColor = .systemGray
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
        
        enum NavBarNotificationBtn {
            static let maxBlurAlpha: CGFloat = 0.8
            static let minBlurAlpha: CGFloat = 0.0
            static let fadeThreshold: CGFloat = 10 // Высота прокрутки, после которой размытие максимально
            static let tintColor: UIColor = .white
            static let imageName: String = "bell.fill"
        }
    }
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let table: UITableView = UITableView()
    private let navBarCenteredTitle: UILabel = UILabel()
    private let navBarNotificationBtn: UIButton = UIButton(type: .system)
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Properties
    private var interactor: (HomeBusinessLogic & HabitsStorage)
    private var blurredNavBarView: UIVisualEffectView?
    private var navBarRendered: Bool = false
    private var isHabitsLoaded: Bool = false
    private var shouldShowMotivationCell: Bool {
        return isHabitsLoaded && isMotivationsCellVisible
    }
    private var selectedDayPart: String = "All day"
    private var selectedDay: Date = Date()
    private var previousDayPartIndex: Int = 0 // "All day"
    private var isMotivationsCellVisible: Bool = true
    
    // MARK: - Lifecycle
    init(interactor: (HomeBusinessLogic & HabitsStorage)) {
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
        configureNotificationCenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllHabits()
        updateNavBarTransparency()
        table.reloadData() // Обновляем таблицу, чтобы мерцающие ячейки снова запустили анимацию
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Так как расчет высоты статус бара и навбара происходит уже после построения интерфейса, то строим навбар в самом конце
        if !navBarRendered {
            configureNavBar()
            configureNavBarCenteredTitle()
            configureNavBarNotificationBtn()
            navBarRendered = true
        }
        updateNavBarTransparency()
        
        // Скроллим к текущей дате
        if let horizontalCollectionDateCell = table.cellForRow(at: IndexPath(row: 0, section: Constants.Table.horizontalDateCollectionCellSectionIndex)) as? HorizontalDateCollectionCell {
            horizontalCollectionDateCell.scrollToCurrentDate(animated: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Methods
    func displayUpdatedHabits(_ viewModel: HomeModels.FetchAllHabits.ViewModel) {
        refreshControl.endRefreshing()
        isHabitsLoaded = true
        table.reloadData()
    }
    
    func retryFetchHabits(_ viewModel: HomeModels.FetchAllHabits.ViewModel) {
        fetchAllHabits()
    }
    
    // MARK: - Private Methods
    private func fetchAllHabits() {
        isHabitsLoaded = false
        interactor.fetchAllHabits(HomeModels.FetchAllHabits.Request())
    }
    
    private func configureUI() {
        configureBackground()
        configureRefreshControl()
        configureTable()
    }
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAppWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
        // Подписываемся на события AddHabitViewController (добавление привычки)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleHabitAddedNotification),
                                               name: .habitAdded,
                                               object: nil)
        
        // Подписываемя на события HabitExecutionViewController (удаление привычки)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleHabitDeletedNotification),
                                               name: .habitDeleted,
                                               object: nil)
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
        navBarCenteredTitle.text = DateManager.shared.getLocalizedMonthAndDay()
        navBarCenteredTitle.textAlignment = Constants.NavBarCenteredTitle.alignment
        navBarCenteredTitle.font = UIFont.systemFont(ofSize: Constants.NavBarCenteredTitle.fontSize, weight: Constants.NavBarCenteredTitle.fontWeight)
        navBarCenteredTitle.textColor = Constants.NavBarCenteredTitle.color
        navBarCenteredTitle.alpha = Constants.NavBarCenteredTitle.minBlurAlpha
        
        navigationItem.titleView = navBarCenteredTitle
        navigationItem.titleView?.alpha = Constants.NavBarCenteredTitle.minBlurAlpha
    }
    
    private func configureNavBarNotificationBtn() {
        navBarNotificationBtn.setImage(UIImage(systemName: Constants.NavBarNotificationBtn.imageName), for: .normal)
        navBarNotificationBtn.tintColor = Constants.NavBarNotificationBtn.tintColor
        navBarNotificationBtn.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        navBarNotificationBtn.alpha = Constants.NavBarNotificationBtn.minBlurAlpha
        
        let barButton = UIBarButtonItem(customView: navBarNotificationBtn)
        navigationItem.rightBarButtonItem = barButton
    }

    private func configureNavBar() {
        // Создаём кастомный цвет размытия
        blurredNavBarView = createCustomBlurView(with: Constants.NavigationBar.blurColor)
        guard let blurredNavBarView = blurredNavBarView else { return }
        view.addSubview(blurredNavBarView)
        blurredNavBarView.alpha = Constants.NavigationBar.minBlurAlpha
        
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let totalNavBarHeight = statusBarHeight + navigationBarHeight
        
        blurredNavBarView.pinTop(to: view.topAnchor)
        blurredNavBarView.pinLeft(to: view.leadingAnchor)
        blurredNavBarView.pinRight(to: view.trailingAnchor)
        blurredNavBarView.setHeight(totalNavBarHeight)

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
        table.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseId)
        table.register(ShimmerHabitCell.self, forCellReuseIdentifier: ShimmerHabitCell.reuseId)
        table.register(AddHabitCell.self, forCellReuseIdentifier: AddHabitCell.reuseId)
        table.register(HomeMotivationsCell.self, forCellReuseIdentifier: HomeMotivationsCell.reuseId)
        table.register(YourHabitsCell.self, forCellReuseIdentifier: YourHabitsCell.reuseId)
        table.layer.masksToBounds = false
        table.alwaysBounceVertical = true
        table.refreshControl = refreshControl
        
        table.pinTop(to: view.topAnchor)
        table.pinBottom(to: view.bottomAnchor)
        table.pinLeft(to: view.leadingAnchor)
        table.pinRight(to: view.trailingAnchor)
        
        table.backgroundColor = Constants.Table.bgColor
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = Constants.RefreshControl.tintColor
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func updateNavBarTransparency() {
        DispatchQueue.main.async {
            self.scrollViewDidScroll(self.table)
        }
    }
    
    // MARK: - Actions
    @objc private func notificationButtonPressed() {
        print("NOTIFICATION SCREEN")
        
    }
    
    @objc private func refreshData() {
        isHabitsLoaded = false
        table.reloadData()
        refreshControl.endRefreshing()
        fetchAllHabits()
    }
    
    @objc private func handleAppWillEnterForeground() {
        DispatchQueue.main.async {
            self.scrollViewDidScroll(self.table)
        }
    }
    
    @objc private func handleHabitAddedNotification(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.fetchAllHabits()
        }
    }
    
    @objc private func handleHabitDeletedNotification(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.fetchAllHabits()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionIndex = indexPath.section
        
        switch sectionIndex {
            
        case Constants.Table.headerCellSectionIndex: return Constants.Table.headerCellHeight
            
        case Constants.Table.horizontalDateCollectionCellSectionIndex: return Constants.Table.horizontalDateCollectionCellHeight
            
        case Constants.Table.dayPartSelectorCellSectionIndex: return Constants.Table.dayPartSelectorCellHeight
            
        case Constants.Table.homeMotivationCellSectionIndex: return Constants.Table.homeMotivationCellHeight
            
        case Constants.Table.yourHabitsCellSectionIndex: return Constants.Table.yourHabitsCellHeight
            
        case Constants.Table.habitCellSectionIndex: return Constants.Table.habitCellHeight
            
        default: return UITableView.automaticDimension
        }
    }
    
    // Popup-экран при удерживании ячейки
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        let section = indexPath.section
        
        guard isHabitsLoaded == true else { return nil } // Если привычки не загружены - ничего не делаем
        guard interactor.habits.isEmpty == false else { return nil } // Если привычек нет - ничего не делаем
        
        if section == Constants.Table.habitCellSectionIndex {
            return UIContextMenuConfiguration(identifier: nil,
                                              previewProvider: {
                let popupVC = PopupHabitViewController()
                popupVC.configure(with: self.interactor.habits[indexPath.row])
                return popupVC
            })
        }
        return nil
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.Table.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case Constants.Table.habitCellSectionIndex:
            if isHabitsLoaded == false {
                return Constants.Table.numberOfShimmerCells
            } else if interactor.habits.isEmpty {
                return Constants.Table.numberOfAddHabitCells
            } else {
                let filteredHabits = selectedDayPart == "All day" ? interactor.habits : interactor.habits.filter { $0.day_part == selectedDayPart }
                return filteredHabits.count
            }
            
        case Constants.Table.homeMotivationCellSectionIndex:
            if interactor.habits.isEmpty {
                return 0
            }
            return shouldShowMotivationCell ? 1 : 0
            
        default:
            return Constants.Table.numberOfRowsInSection
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == Constants.Table.yourHabitsCellSectionIndex { // Убираем отступ после секции YourHabits
            return 0
        }
        
        if isMotivationsCellVisible == false  && section == Constants.Table.homeMotivationCellSectionIndex { // Если ячейка с мотивацией скрыта, то убираем отступ между секциями
            return 0
        }
        
        return Constants.Table.indentBetweenSections
    }
    
    // Заглушка для работы метода heightForFooterInSection
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView: UIView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIndex = indexPath.section
        
        switch sectionIndex {
            
        // HeaderCell
        case Constants.Table.headerCellSectionIndex:
            let cell = table.dequeueReusableCell(withIdentifier: HeaderCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let headerCell = cell as? HeaderCell else { return cell }
            
            let currentDate = DateManager.shared.getLocalizedMonthAndDay()
            headerCell.configure(with: currentDate)
            
            headerCell.onProfileImageTapped = { [weak self] in
                guard let self = self else { return }
                
                self.interactor.routeToProfileScreen(HomeModels.RouteToProfileScreen.Request())
            }
            
            headerCell.onTodayLabelTapped = {
                headerCell.swapTodayAndDateLabels()
            }
            
            return headerCell
        
        // HorizontalDateCollectionCell
        case Constants.Table.horizontalDateCollectionCellSectionIndex:
            let cell = table.dequeueReusableCell(withIdentifier: HorizontalDateCollectionCell.reuseId, for: indexPath)
            cell.selectionStyle = .none
            guard let horizontalDateCollectionCell = cell as? HorizontalDateCollectionCell else { return cell }
            
            horizontalDateCollectionCell.onDateTapped = { [weak self] date in
                self?.selectedDay = date
                
                self?.table.reloadSections(IndexSet(integer: Constants.Table.habitCellSectionIndex), with: .automatic)
            }
            
            return horizontalDateCollectionCell
            
        // DayPartSelectorCell
        case Constants.Table.dayPartSelectorCellSectionIndex:
            let cell = table.dequeueReusableCell(withIdentifier: DayPartSelectorCell.reuseId, for: indexPath)
            guard let dayPartSelectorCell = cell as? DayPartSelectorCell else { return cell }
            
            dayPartSelectorCell.onDayPartTapped = { [weak self] dayPart, newDayPartIndex in
                guard let self = self else { return }
                
                let animationDirection: UITableView.RowAnimation = newDayPartIndex > self.previousDayPartIndex ? .left : .right
                self.previousDayPartIndex = newDayPartIndex
                self.selectedDayPart = dayPart
                
                self.table.reloadSections(IndexSet(integer: Constants.Table.habitCellSectionIndex), with: animationDirection)
            }
            
            return dayPartSelectorCell
            
        // HomeMotivationsCell
        case Constants.Table.homeMotivationCellSectionIndex:
            let cell = table.dequeueReusableCell(withIdentifier: HomeMotivationsCell.reuseId, for: indexPath)
            guard let homeMotivationsCell = cell as? HomeMotivationsCell else { return cell }
            homeMotivationsCell.selectionStyle = .none
            
            let habitCount = interactor.habits.count
            let completedHabitsCount = interactor.habits.filter { $0.current_quantity == $0.quantity }.count
            let percentage = habitCount > 0 ? (completedHabitsCount * 100 / habitCount) : 0
            let header = MotivationsManager.shared.motivationalPhrase(for: percentage)
            let descriptionText = "\(completedHabitsCount) of \(habitCount) completed"
            
            homeMotivationsCell.configure(percentage: "\(percentage)%", header: header, description: descriptionText)
            
            homeMotivationsCell.onCloseButtonTapped = { [weak self] in
                self?.isMotivationsCellVisible = false
                self?.table.reloadData()
            }
            
            return homeMotivationsCell
            
        // YourHabitsCell
        case Constants.Table.yourHabitsCellSectionIndex:
            let cell = table.dequeueReusableCell(withIdentifier: YourHabitsCell.reuseId, for: indexPath)
            guard let yourHabitsCell = cell as? YourHabitsCell else { return cell }
            yourHabitsCell.selectionStyle = .none
            
            return yourHabitsCell
            
        // HabitCell
        case Constants.Table.habitCellSectionIndex:
            if isHabitsLoaded == false { // Пока привычки не загружены - показываем мерцающие ячейки
                let cell = table.dequeueReusableCell(withIdentifier: ShimmerHabitCell.reuseId, for: indexPath)
                guard let shimmerHabitCell = cell as? ShimmerHabitCell else { return cell }
                shimmerHabitCell.selectionStyle = .none
                
                shimmerHabitCell.startShimmer()
                
                return shimmerHabitCell
            }
            
            if interactor.habits.isEmpty { // Если привычек нет - показываем ячейку для добавления привычек
                let cell = table.dequeueReusableCell(withIdentifier: AddHabitCell.reuseId, for: indexPath)
                guard let addHabitCell = cell as? AddHabitCell else { return cell }
                addHabitCell.selectionStyle = .none
                
                return addHabitCell
            }
            
            let filteredHabits = selectedDayPart == "All day" ? interactor.habits : interactor.habits.filter { $0.day_part == selectedDayPart }
            
            let cell = table.dequeueReusableCell(withIdentifier: HabitCell.reuseId, for: indexPath)
            guard let habitCell = cell as? HabitCell else { return cell }
            habitCell.selectionStyle = .none
            
            let habit = filteredHabits[indexPath.row]
            habitCell.configure(with: habit)
            
            habitCell.onCheckmarkTapped = { [weak self] updatedHabit in
                guard let self = self else { return }
                
                self.interactor.updateHabitExecution(HomeModels.UpdateHabitExecution.Request(
                    habit: updatedHabit,
                    onFinish: { [weak self] in
                        self?.fetchAllHabits()
                    }
                ))
            }
            
            return habitCell
        
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        switch section {
        // habitCellSectionIndex
        case Constants.Table.habitCellSectionIndex:
            guard isHabitsLoaded == true else { return } // Если привычки не загружены - ничего не делаем
            if interactor.habits.isEmpty { // Если привычки загружены и их нет - направляем на экран добавления привычки
                interactor.routeToAddHabitScreen(HomeModels.RouteToAddHabitScreen.Request())
                return
            }
            // В остальных случаях направляем на экран выполнения привычки
            let habit = interactor.habits[indexPath.row]
            interactor.routeToHabitExecutionScreen(HomeModels.RouteToHabitExecutionScreen.Request(habit: habit, onDismiss: { [weak self] in
                self?.fetchAllHabits()
            }))
        default:
            return
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
        
        let offset = max(scrollView.contentOffset.y + totalNavBarHeight, 0)
        
        let blurAlpha = max(Constants.NavigationBar.minBlurAlpha,
                        min(Constants.NavigationBar.maxBlurAlpha, offset / Constants.NavigationBar.fadeThreshold))
        let titleAlpha = max(Constants.NavBarCenteredTitle.minBlurAlpha,
                             min(Constants.NavBarCenteredTitle.maxBlurAlpha, offset / Constants.NavBarCenteredTitle.fadeThreshold))
        let notificationBtnAlpha = max(Constants.NavBarNotificationBtn.minBlurAlpha,
                             min(Constants.NavBarNotificationBtn.maxBlurAlpha, offset / Constants.NavBarNotificationBtn.fadeThreshold))
        blurredNavBarView.alpha = blurAlpha
        navBarCenteredTitle.alpha = titleAlpha
        navBarNotificationBtn.alpha = notificationBtnAlpha
    }
}
