//
//  DayPartSelectorCell.swift
//  Doordie
//
//  Created by Arseniy on 30.12.2024.
//

import Foundation
import UIKit

final class DayPartSelectorCell: UITableViewCell {
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
            static let width: CGFloat = 100
            static let height: CGFloat = 40
            static let minimumLineSpacing: CGFloat = 0
            static let minimumInteritemSpacing: CGFloat = 0
        }
        
        enum DayPartTable {
            static let parts: [String] = ["All day", "Morning", "Day", "Evening", "Night"]
            static let bgColor: UIColor = .clear
            static let elementsLeadingIndent: CGFloat = 18
            static let elementsTrailingIndent: CGFloat = 18
            static let elementsTopIndent: CGFloat = 0
            static let elementsBottomIndent: CGFloat = 0
        }
    }
    
    static let reuseId: String = "DayPartSelectorCell"
    
    // MARK: - UI Components
    private let dayPartTable: UICollectionView
    
    // MARK: - Variables
    var onDayPartTapped: (() -> Void)?
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.dayPartTable = DayPartSelectorCell.createCollectionView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        configureDayPartTable()
    }
    
    private func configureDayPartTable() {
        contentView.addSubview(dayPartTable)
    
        dayPartTable.showsHorizontalScrollIndicator = false
        dayPartTable.backgroundColor = Constants.DayPartTable.bgColor
        dayPartTable.delegate = self
        dayPartTable.dataSource = self
        dayPartTable.register(DayPartCell.self, forCellWithReuseIdentifier: DayPartCell.reuseId)
        
        dayPartTable.pinLeft(to: contentView.leadingAnchor)
        dayPartTable.pinRight(to: contentView.trailingAnchor)
        dayPartTable.pinTop(to: contentView.topAnchor)
        dayPartTable.pinBottom(to: contentView.bottomAnchor)
    }
    
    // MARK: - Actions
    @objc
    private func dayPartTapped() {
        onDayPartTapped?()
    }
}

// MARK: - UICollectionViewDelegate
extension DayPartSelectorCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DayPartSelectorCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.DayPartTable.elementsTopIndent,
                            left: Constants.DayPartTable.elementsLeadingIndent,
                            bottom: Constants.DayPartTable.elementsBottomIndent,
                            right: Constants.DayPartTable.elementsTrailingIndent) // Отступы слева и справа
    }
}

// MARK: - UICollectionViewDataSource
extension DayPartSelectorCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.DayPartTable.parts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dayPartTable.dequeueReusableCell(withReuseIdentifier: DayPartCell.reuseId, for: indexPath)
        guard let dayPartCell = cell as? DayPartCell else { return cell }
        
        dayPartCell.configure(with: Constants.DayPartTable.parts[indexPath.row])
        
        // Устанавливаем цвет ячейки в зависимости от того, выбрана ли она
        if selectedIndexPath == indexPath {
            dayPartCell.didSelect()
        } else {
            dayPartCell.unselect()
        }
        
        return dayPartCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        
        // Обновляем текущую и предыдущую ячейкРи
        var indexPathsToReload = [indexPath]
        if let previousIndexPath = previousIndexPath {
            indexPathsToReload.append(previousIndexPath)
        }
        collectionView.reloadItems(at: indexPathsToReload)
    }
}
