//
//  HabitPerformanceCell.swift
//  Doordie
//
//  Created by Arseniy on 07.04.2025.
//

import UIKit

final class HabitPerformanceCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let bgColor: UIColor = .clear
            static let height: CGFloat = 250
            static let bottomIndent: CGFloat = 30
        }
        
        enum ColoredWrap {
            static let height: CGFloat = 220
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let topIndent: CGFloat = 30
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
        enum DailyPerformanceLabel {
            static let text: String = "DAILY PERFORMANCE"
            static let textColor: UIColor = .white.withAlphaComponent(0.8)
            static let font = UIFont.systemFont(ofSize: 14)
            static let textAlignment: NSTextAlignment = .left
            static let bottomIndent: CGFloat = 4
        }
        
        enum LastSevenDaysLabel {
            static let text: String = "LAST 7 DAYS"
            static let textColor: UIColor = .white.withAlphaComponent(0.8)
            static let font = UIFont.systemFont(ofSize: 14)
            static let textAlignment: NSTextAlignment = .left
            static let bottomIndent: CGFloat = 4
        }
        
        enum AnalyticsCollectionView {
            static let height: CGFloat = 200
            static let leadingIndent: CGFloat = 10
            static let trailingIndent: CGFloat = 10
            static let bottomIndent: CGFloat = 10
            static let topIndent: CGFloat = 10
        }
    }
    
    static let reuseId: String = "HabitPerformanceCell"
    
    // MARK: - UI Components
    private let wrap: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Wrap.bgColor
        return view
    }()
    
    private let coloredWrap: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.ColoredWrap.bgColor
        view.layer.cornerRadius = Constants.ColoredWrap.cornerRadius
        view.layer.shadowColor = Constants.ColoredWrap.shadowColor
        view.layer.shadowOpacity = Constants.ColoredWrap.shadowOpacity
        view.layer.shadowOffset = CGSize(width: Constants.ColoredWrap.shadowOffsetX, height: Constants.ColoredWrap.shadowOffsetY)
        view.layer.shadowRadius = Constants.ColoredWrap.shadowRadius
        view.layer.masksToBounds = false
        return view
    }()
    
    private let dailyPerformanceLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.DailyPerformanceLabel.text
        label.textColor = Constants.DailyPerformanceLabel.textColor
        label.textAlignment = Constants.DailyPerformanceLabel.textAlignment
        label.font = Constants.DailyPerformanceLabel.font
        return label
    }()
    
    private let lastSevenDaysLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.LastSevenDaysLabel.text
        label.textColor = Constants.LastSevenDaysLabel.textColor
        label.textAlignment = Constants.LastSevenDaysLabel.textAlignment
        label.font = Constants.LastSevenDaysLabel.font
        return label
    }()
    
    private let analyticsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        collection.layer.masksToBounds = false
        
        collection.register(AnalyticsCollectionViewCell.self, forCellWithReuseIdentifier: AnalyticsCollectionViewCell.reuseId)
        
        return collection
    }()
    
    // MARK: - Properties
    private var dates: [DateModel] = DateManager.shared.getLastSevenDays()
    private var habitData: [AnalyticsModels.HabitAnalytics] = []
    private var barCounts: [Int] = []
    private var barHeights: [CGFloat] = []
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        analyticsCollectionView.delegate = self
        analyticsCollectionView.dataSource = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with habits: [AnalyticsModels.HabitAnalytics]) {
        self.habitData = habits
        computeBarData()
        analyticsCollectionView.reloadData()
    }
    
    func scrollToCenter() {
        let numberOfItems = analyticsCollectionView.numberOfItems(inSection: 0)
        guard numberOfItems > 0 else { return }
        let centerItem = numberOfItems / 2
        let centerIndexPath = IndexPath(item: centerItem, section: 0)
        
        analyticsCollectionView.scrollToItem(at: centerIndexPath,
                                         at: .centeredHorizontally,
                                         animated: false)
    }
    
    // MARK: - Private Methods
    private func computeBarData() {
        barCounts = Array(repeating: 0, count: dates.count)
        barHeights = Array(repeating: 0, count: dates.count)
        
        for (index, dateModel) in dates.enumerated() {
            let targetDate = dateModel.date
            var count = 0
            for habit in habitData {
                for execution in habit.executions {
                    if execution.execution_date == targetDate {
                        count += 1
                    }
                }
            }
            barCounts[index] = count
        }
        
        guard let maxCount = barCounts.max(), maxCount > 0 else {
            return
        }
        
        let maxBarHeight: CGFloat = 140.0
        
        for (index, count) in barCounts.enumerated() {
            let height = (CGFloat(count) / CGFloat(maxCount)) * maxBarHeight
            barHeights[index] = height
        }
    }
    
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        contentView.addSubview(wrap)
        wrap.addSubview(coloredWrap)
        wrap.addSubview(dailyPerformanceLabel)
        wrap.addSubview(lastSevenDaysLabel)
        wrap.addSubview(analyticsCollectionView)
    }
    
    private func configureConstraints() {
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor, Constants.Wrap.bottomIndent)
        
        coloredWrap.setHeight(Constants.ColoredWrap.height)
        coloredWrap.pinCenterX(to: wrap.centerXAnchor)
        coloredWrap.pinLeft(to: wrap.leadingAnchor)
        coloredWrap.pinBottom(to: wrap.bottomAnchor)
        coloredWrap.pinTop(to: wrap.topAnchor, Constants.ColoredWrap.topIndent)
        
        analyticsCollectionView.pinTop(to: coloredWrap.topAnchor, Constants.AnalyticsCollectionView.topIndent)
        analyticsCollectionView.pinLeft(to: coloredWrap.leadingAnchor, Constants.AnalyticsCollectionView.leadingIndent)
        analyticsCollectionView.pinRight(to: coloredWrap.trailingAnchor, Constants.AnalyticsCollectionView.trailingIndent)
        analyticsCollectionView.pinBottom(to: coloredWrap.bottomAnchor, Constants.AnalyticsCollectionView.bottomIndent)
        
        dailyPerformanceLabel.pinBottom(to: coloredWrap.topAnchor, Constants.DailyPerformanceLabel.bottomIndent)
        dailyPerformanceLabel.pinLeft(to: wrap.leadingAnchor)
        
        lastSevenDaysLabel.pinBottom(to: coloredWrap.topAnchor, Constants.LastSevenDaysLabel.bottomIndent)
        lastSevenDaysLabel.pinRight(to: wrap.trailingAnchor)
    }
}

// MARK: - UICollectionViewDelegate
extension HabitPerformanceCell: UICollectionViewDelegate { }

extension HabitPerformanceCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 36, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {

        let cellCount: CGFloat = 7
        let cellWidth: CGFloat = 36.0
        let totalCellWidth = cellCount * cellWidth
        let inset = max((collectionView.frame.width - totalCellWidth) / 2, 0)
        
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}

// MARK: - UICollectionViewDataSource
extension HabitPerformanceCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = analyticsCollectionView.dequeueReusableCell(withReuseIdentifier: AnalyticsCollectionViewCell.reuseId, for: indexPath)
        guard let analyticsCollectionViewCell = cell as? AnalyticsCollectionViewCell else { return cell }
        
        let dayName = dates[indexPath.row].name
        let count = barCounts[indexPath.row]
        let height = barHeights[indexPath.row]
        analyticsCollectionViewCell.configure(dayText: dayName, count: count, height: height)
        
        return analyticsCollectionViewCell
    }
}
