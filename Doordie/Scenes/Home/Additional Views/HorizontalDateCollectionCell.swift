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
        // UI
        static let contentViewBgColor: UIColor = .clear
        static let cellBgColor: UIColor = .clear
        static let contentViewHeight: CGFloat = 100
    }
    
    static let reuseId: String = "HorizontalDateCollectionCell"
    private var selectedIndexPath: IndexPath?
    
    // MARK: - UI Components
    private let dateTable: UICollectionView
    
    // MARK: - Variables
    var onDateTapped: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.dateTable = HorizontalDateCollectionCell.createCollectionView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure() {
        
    }
    
    // MARK: - Private Methods
    private static func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.layer.masksToBounds = false
        return collectionView
    }
    
    private func configureUI() {
        backgroundColor = Constants.cellBgColor
        contentView.backgroundColor = Constants.contentViewBgColor
        
        configureDateTable()
    }
    
    private func configureDateTable() {
        contentView.addSubview(dateTable)
    
        dateTable.showsHorizontalScrollIndicator = false
        dateTable.backgroundColor = .clear
        dateTable.delegate = self
        dateTable.dataSource = self
        dateTable.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseId)
        
        dateTable.pinLeft(to: contentView.leadingAnchor)
        dateTable.pinRight(to: contentView.trailingAnchor)
        dateTable.pinTop(to: contentView.topAnchor)
        dateTable.pinBottom(to: contentView.bottomAnchor)
    }
    
    // MARK: - Actions
    @objc
    private func dateTapped() {
        onDateTapped?()
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalDateCollectionCell: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalDateCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18) // Отступы слева и справа
    }
}

// MARK: - UICollectionViewDataSource
extension HorizontalDateCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dateTable.dequeueReusableCell(withReuseIdentifier: DateCell.reuseId, for: indexPath)
        guard let dateCell = cell as? DateCell else { return cell }
        
        dateCell.configure()
        
        // Устанавливаем цвет ячейки в зависимости от того, выбрана ли она
        if selectedIndexPath == indexPath {
            dateCell.didSelect()
        } else {
            dateCell.unselect()
        }
        
        return dateCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        
        // Обновляем текущую и предыдущую ячейки
        var indexPathsToReload = [indexPath]
        if let previousIndexPath = previousIndexPath {
            indexPathsToReload.append(previousIndexPath)
        }
        collectionView.reloadItems(at: indexPathsToReload)
    }
}
