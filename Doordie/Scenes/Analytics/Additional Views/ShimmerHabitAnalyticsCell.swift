//
//  ShimmerHabitAnalyticsCell.swift
//  Doordie
//
//  Created by Arseniy on 07.04.2025.
//

import UIKit

final class ShimmerHabitAnalyticsCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum ShimmerWrap {
            static let height: CGFloat = 140
            static let cornerRadius: CGFloat = 14
            static let bottomIndent: CGFloat = 10
        }
        
        enum ShimmerColoredWrap {
            static let side: CGFloat = 50
            static let cornerRadius: CGFloat = 14
            static let topIndent: CGFloat = 8
            static let leadingIndent: CGFloat = 8
        }
        
        enum ShimmerNameLabel {
            static let height: CGFloat = 18
            static let width: CGFloat = 150
            static let cornerRadius: CGFloat = 9
            static let leadingIndent: CGFloat = 12
        }
        
        enum DatesCollectionView {
            static let height: CGFloat = 60
            static let leadingIndent: CGFloat = 8
            static let trailingIndent: CGFloat = 8
            static let bottomIndent: CGFloat = 8
        }
    }
    
    static let reuseId: String = "ShimmerHabitAnalyticsCell"
    
    // MARK: - UI Components
    private let shimmerWrap: ShimmerView = {
        let view = ShimmerView()
        view.layer.cornerRadius = Constants.ShimmerWrap.cornerRadius
        return view
    }()
    
    private let shimmerColoredWrap: ShimmerView = {
        let view = ShimmerView()
        view.layer.cornerRadius = Constants.ShimmerColoredWrap.cornerRadius
        return view
    }()
    
    private let shimmerNameLabel: ShimmerView = {
        let view = ShimmerView()
        view.layer.cornerRadius = Constants.ShimmerNameLabel.cornerRadius
        return view
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
        
        collection.register(ShimmerDateCollectionViewCell.self, forCellWithReuseIdentifier: ShimmerDateCollectionViewCell.reuseId)
        
        return collection
    }()
    
    // MARK: - Properties
    private var dates: [DateModel] = DateManager.shared.getLastSevenDays()
    private var habitData: HabitAnalytics?
    
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
    func startShimmer() {
        shimmerWrap.startAnimating()
        shimmerColoredWrap.startAnimating()
        shimmerNameLabel.startAnimating()
    }

    func stopShimmer() {
        shimmerWrap.stopAnimating()
        shimmerColoredWrap.stopAnimating()
        shimmerNameLabel.stopAnimating()
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
        contentView.addSubview(shimmerWrap)
        shimmerWrap.addSubview(shimmerColoredWrap)
        shimmerWrap.addSubview(shimmerNameLabel)
        shimmerWrap.addSubview(datesCollectionView)
    }
    
    private func configureConstraints() {
        shimmerWrap.setHeight(Constants.ShimmerWrap.height)
        shimmerWrap.pinTop(to: contentView.topAnchor)
        shimmerWrap.pinLeft(to: contentView.leadingAnchor)
        shimmerWrap.pinRight(to: contentView.trailingAnchor)
        shimmerWrap.pinBottom(to: contentView.bottomAnchor, Constants.ShimmerWrap.bottomIndent)
        
        shimmerColoredWrap.pinTop(to: shimmerWrap.topAnchor, Constants.ShimmerColoredWrap.topIndent)
        shimmerColoredWrap.pinLeft(to: shimmerWrap.leadingAnchor, Constants.ShimmerColoredWrap.leadingIndent)
        shimmerColoredWrap.setHeight(Constants.ShimmerColoredWrap.side)
        shimmerColoredWrap.setWidth(Constants.ShimmerColoredWrap.side)
        
        shimmerNameLabel.setHeight(Constants.ShimmerNameLabel.height)
        shimmerNameLabel.setWidth(Constants.ShimmerNameLabel.width)
        shimmerNameLabel.pinCenterY(to: shimmerColoredWrap.centerYAnchor)
        shimmerNameLabel.pinLeft(to: shimmerColoredWrap.trailingAnchor, Constants.ShimmerNameLabel.leadingIndent)
        
        datesCollectionView.setHeight(Constants.DatesCollectionView.height)
        datesCollectionView.pinLeft(to: shimmerWrap.leadingAnchor, Constants.DatesCollectionView.leadingIndent)
        datesCollectionView.pinRight(to: shimmerWrap.trailingAnchor, Constants.DatesCollectionView.trailingIndent)
        datesCollectionView.pinBottom(to: shimmerWrap.bottomAnchor, Constants.DatesCollectionView.bottomIndent)
    }
}

// MARK: - UICollectionViewDelegate
extension ShimmerHabitAnalyticsCell: UICollectionViewDelegate { }

extension ShimmerHabitAnalyticsCell: UICollectionViewDelegateFlowLayout {
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
extension ShimmerHabitAnalyticsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = datesCollectionView.dequeueReusableCell(withReuseIdentifier: ShimmerDateCollectionViewCell.reuseId, for: indexPath)
        guard let shimmerDateCollectionViewCell = cell as? ShimmerDateCollectionViewCell else { return cell }
        
        shimmerDateCollectionViewCell.startShimmer()
        
        return shimmerDateCollectionViewCell
    }
}
