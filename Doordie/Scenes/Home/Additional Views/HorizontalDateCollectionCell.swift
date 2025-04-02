//
//  MonthDateCell.swift
//  Doordie
//
//  Created by Arseniy on 29.12.2024.
//

import Foundation
import UIKit

final class HorizontalDateCollectionCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Layout {
            static let scrollDirection: UICollectionView.ScrollDirection = .horizontal
            static let width: CGFloat = 80
            static let height: CGFloat = 100
            static let minimumLineSpacing: CGFloat = 10
            static let minimumInteritemSpacing: CGFloat = 10
        }
        
        enum DateTable {
            static let bgColor: UIColor = .clear
            static let elementsLeadingIndent: CGFloat = 18
            static let elementsTrailingIndent: CGFloat = 18
            static let elementsTopIndent: CGFloat = 0
            static let elementsBottomIndent: CGFloat = 0
            static let isScrollEnabled: Bool = false
        }
    }
    
    static let reuseId: String = "HorizontalDateCollectionCell"
    
    // MARK: - UI Components
    private let dateTable: UICollectionView
    
    // MARK: - Properties
    var onDateTapped: ((Date) -> Void)?
    private var selectedIndexPath: IndexPath? = IndexPath(row: 30, section: 0)
    private var days: [DayInfo] = []
    private var isHabitsLoaded: Bool = true
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.dateTable = HorizontalDateCollectionCell.createCollectionView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        
        days = DateManager.shared.getDaysInfo()
        dateTable.reloadData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func scrollToCurrentDate(animated: Bool = false) {
        selectedIndexPath = IndexPath(row: 30, section: 0)
        dateTable.scrollToItem(at: selectedIndexPath!, at: .centeredHorizontally, animated: animated)
        dateTable.reloadItems(at: [selectedIndexPath!])
    }
    
    func ShowShimmer() {
        isHabitsLoaded = false
    }
    
    func HideShimmer() {
        isHabitsLoaded = true
    }
    
    // MARK: - Private Methods
    private static func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = Constants.Layout.scrollDirection
        layout.itemSize = CGSize(width: Constants.Layout.width, height: Constants.Layout.height)
        layout.minimumLineSpacing = Constants.Layout.minimumLineSpacing
        layout.minimumInteritemSpacing = Constants.Layout.minimumInteritemSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        return collectionView
    }
    
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        
        configureDateTable()
    }
    
    private func configureDateTable() {
        contentView.addSubview(dateTable)
    
        dateTable.showsHorizontalScrollIndicator = false
        dateTable.backgroundColor = Constants.DateTable.bgColor
        dateTable.delegate = self
        dateTable.dataSource = self
        dateTable.isScrollEnabled = Constants.DateTable.isScrollEnabled
        dateTable.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseId)
        dateTable.register(ShimmerDateCell.self, forCellWithReuseIdentifier: ShimmerDateCell.reuseId)
        
        dateTable.pinLeft(to: contentView.leadingAnchor)
        dateTable.pinRight(to: contentView.trailingAnchor)
        dateTable.pinTop(to: contentView.topAnchor)
        dateTable.pinBottom(to: contentView.bottomAnchor)
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalDateCollectionCell: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalDateCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.DateTable.elementsTopIndent,
                            left: Constants.DateTable.elementsLeadingIndent,
                            bottom: Constants.DateTable.elementsBottomIndent,
                            right: Constants.DateTable.elementsTrailingIndent) // Отступы слева и справа
    }
}

// MARK: - UICollectionViewDataSource
extension HorizontalDateCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch isHabitsLoaded {
        case true:
            let cell = dateTable.dequeueReusableCell(withReuseIdentifier: DateCell.reuseId, for: indexPath)
            guard let dateCell = cell as? DateCell else { return cell }
            
            let dayInfo = days[indexPath.row]
            dateCell.configure(dayNumber: dayInfo.dayNumber, weekDay: dayInfo.weekDay)
            
            // Устанавливаем цвет ячейки в зависимости от того, выбрана ли она
            if selectedIndexPath == indexPath {
                dateCell.didSelect()
            } else {
                dateCell.unselect()
            }
            
            return dateCell
        case false:
            let cell = dateTable.dequeueReusableCell(withReuseIdentifier: ShimmerDateCell.reuseId, for: indexPath)
            guard let shimmerDateCell = cell as? ShimmerDateCell else { return cell }
            
            shimmerDateCell.startShimmer()
            
            return shimmerDateCell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let previousIndexPath = selectedIndexPath
//        selectedIndexPath = indexPath
//        
//        let selectedDay = days[indexPath.row]
//        onDateTapped?(selectedDay.date)
//        
//        // Обновляем текущую и предыдущую ячейкРи
//        var indexPathsToReload = [indexPath]
//        if let previousIndexPath = previousIndexPath {
//            indexPathsToReload.append(previousIndexPath)
//        }
//        collectionView.reloadItems(at: indexPathsToReload)
//        
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
}
