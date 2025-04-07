//
//  DateCollectionViewCell.swift
//  Doordie
//
//  Created by Arseniy on 06.04.2025.
//

import UIKit

final class DateCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Wrap {
            static let height: CGFloat = 60
            static let width: CGFloat = 36
        }
        
        enum SquareView {
            static let side: CGFloat = 36
        }
    }
    
    static let reuseId: String = "DateCollectionViewCell"
    
    // MARK: - UI Components
    private let wrap: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tue"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let squareView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "6475CC")
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "31"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(dayText: String, dateText: String, isCompleted: Bool) {
        dayLabel.text = dayText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: dateText) {
            dateFormatter.dateFormat = "d"
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        if isCompleted {
            squareView.backgroundColor = UIColor(hex: "478039")
            dateLabel.tintColor = UIColor(hex: "8DFC63")
        } else {
            squareView.backgroundColor = UIColor(hex: "6475CC")
            dateLabel.tintColor = .white
        }
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        contentView.addSubview(wrap)
        wrap.addSubview(dayLabel)
        wrap.addSubview(squareView)
        squareView.addSubview(dateLabel)
    }
    
    private func configureConstraints() {
        wrap.pin(to: contentView)
        wrap.setHeight(Constants.Wrap.height)
        wrap.setWidth(Constants.Wrap.width)
        
        dayLabel.pinTop(to: wrap.topAnchor)
        dayLabel.pinCenterX(to: wrap.centerXAnchor)
        
        squareView.pinTop(to: dayLabel.bottomAnchor)
        squareView.pinCenterX(to: wrap.centerXAnchor)
        squareView.setHeight(Constants.SquareView.side)
        squareView.setWidth(Constants.SquareView.side)
        
        dateLabel.pinCenterY(to: squareView.centerYAnchor)
        dateLabel.pinCenterX(to: squareView.centerXAnchor)
    }
}
