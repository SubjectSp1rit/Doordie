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
            static let bgColor: UIColor = .clear
        }
        
        enum SquareView {
            static let bgColor: UIColor = UIColor(hex: "6475CC")
            static let cornerRadius: CGFloat = 14
            static let masksToBounds: Bool = true
            static let side: CGFloat = 36
        }
        
        enum DayLabel {
            static let font: UIFont = UIFont.systemFont(ofSize: 12)
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
        }
        
        enum DateLabel {
            static let font: UIFont = UIFont.systemFont(ofSize: 14)
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
        }
    }
    
    static let reuseId: String = "DateCollectionViewCell"
    
    // MARK: - UI Components
    private let wrap: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Wrap.bgColor
        return view
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.DayLabel.font
        label.textColor = Constants.DayLabel.textColor
        label.textAlignment = Constants.DayLabel.textAlignment
        return label
    }()
    
    private let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.SquareView.bgColor
        view.layer.cornerRadius = Constants.SquareView.cornerRadius
        view.layer.masksToBounds = Constants.SquareView.masksToBounds
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.DateLabel.font
        label.textColor = Constants.DateLabel.textColor
        label.textAlignment = Constants.DateLabel.textAlignment
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
