//
//  HabitAnalyticsCell.swift
//  Doordie
//
//  Created by Arseniy on 06.04.2025.
//

import UIKit

final class HabitAnalyticsCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 140
            static let bottomIndent: CGFloat = 10
        }
        
        enum ColoredWrap {
            static let side: CGFloat = 50
            static let topIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 8
        }
        
        enum IconImageView {
            static let sizeMultiplier: CGFloat = 0.8
            static let contentMode: UIImageView.ContentMode = .scaleAspectFit
        }
        
        enum NameLabel {
            static let leadingIndent: CGFloat = 12
        }
        
        enum DatesCollectionView {
            static let height: CGFloat = 60
            static let leadingIndent: CGFloat = 8
            static let trailingIndent: CGFloat = 8
            static let bottomIndent: CGFloat = 8
        }
    }
    
    static let reuseId: String = "HabitAnalyticsCell"
    
    // MARK: - UI Components
    private let wrap: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let coloredWrap: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = Constants.IconImageView.contentMode
        imageView.tintColor = .white
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var datesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        
        collection.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.reuseId)
        
        return collection
    }()
    
    // MARK: - Properties
    private var dates: [DateModel] = DateManager.shared.getLastSevenDays()
    private var habitData: AnalyticsModels.HabitAnalytics?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        
        datesCollectionView.dataSource = self
        datesCollectionView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollToCenter()
    }
    
    // MARK: - Methods
    func configure(with data: AnalyticsModels.HabitAnalytics) {
        habitData = data
        guard let title = data.title else { return }
        guard let icon = data.icon else { return }
        guard let color = data.color else { return }
        nameLabel.text = title
        iconImageView.image = UIImage(systemName: icon)
        coloredWrap.backgroundColor = UIColor(hex: color)
    }
    
    func scrollToCenter() {
        let numberOfItems = datesCollectionView.numberOfItems(inSection: 0)
        guard numberOfItems > 0 else { return }
        let centerItem = numberOfItems / 2
        let centerIndexPath = IndexPath(item: centerItem, section: 0)
        
        datesCollectionView.scrollToItem(at: centerIndexPath,
                                         at: .centeredHorizontally,
                                         animated: false)
    }
    
    func reloadData() {
        datesCollectionView.reloadData()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        contentView.addSubview(wrap)
        wrap.addSubview(coloredWrap)
        coloredWrap.addSubview(iconImageView)
        wrap.addSubview(nameLabel)
        wrap.addSubview(datesCollectionView)
    }
    
    private func configureConstraints() {
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor)
        wrap.pinRight(to: contentView.trailingAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor, Constants.Wrap.bottomIndent)
        
        coloredWrap.pinTop(to: wrap.topAnchor, Constants.ColoredWrap.topIndent)
        coloredWrap.pinLeft(to: wrap.leadingAnchor, Constants.ColoredWrap.leadingIndent)
        coloredWrap.setHeight(Constants.ColoredWrap.side)
        coloredWrap.setWidth(Constants.ColoredWrap.side)
        
        iconImageView.pinCenterX(to: coloredWrap.centerXAnchor)
        iconImageView.pinCenterY(to: coloredWrap.centerYAnchor)
        iconImageView.pinWidth(to: coloredWrap.widthAnchor, Constants.IconImageView.sizeMultiplier)
        iconImageView.pinHeight(to: coloredWrap.heightAnchor, Constants.IconImageView.sizeMultiplier)
        
        nameLabel.pinCenterY(to: coloredWrap.centerYAnchor)
        nameLabel.pinLeft(to: coloredWrap.trailingAnchor, Constants.NameLabel.leadingIndent)
        
        datesCollectionView.setHeight(Constants.DatesCollectionView.height)
        datesCollectionView.pinLeft(to: wrap.leadingAnchor, Constants.DatesCollectionView.leadingIndent)
        datesCollectionView.pinRight(to: wrap.trailingAnchor, Constants.DatesCollectionView.trailingIndent)
        datesCollectionView.pinBottom(to: wrap.bottomAnchor, Constants.DatesCollectionView.bottomIndent)
    }
}

// MARK: - UICollectionViewDelegate
extension HabitAnalyticsCell: UICollectionViewDelegate { }

extension HabitAnalyticsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 36, height: 60)
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
extension HabitAnalyticsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = datesCollectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.reuseId, for: indexPath)
        guard let dateCollectionViewCell = cell as? DateCollectionViewCell else { return cell }
        
        let dayName = dates[indexPath.row].name
        let date = dates[indexPath.row].date
        let isCompleted = habitData?.executions.contains { execution in
            execution.execution_date == date
        }
        dateCollectionViewCell.configure(dayText: dayName, dateText: date, isCompleted: isCompleted ?? false)
        
        return dateCollectionViewCell
    }
}
