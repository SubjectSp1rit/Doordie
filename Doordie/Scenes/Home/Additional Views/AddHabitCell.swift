//
//  AddHabitCell.swift
//  Doordie
//
//  Created by Arseniy on 24.03.2025.
//

import UIKit

final class AddHabitCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 70
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 14
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
            static let bottomIndent: CGFloat = 10
        }
        
        enum HabitImageWrap {
            static let height: CGFloat = 46
            static let width: CGFloat = 46
            static let cornerRadius: CGFloat = 23
            static let bgColor: UIColor = UIColor(hex: "6475CC")
            static let leadingIndent: CGFloat = 14
        }
        
        enum HabitImage {
            static let imageName: String = "plus"
            static let tintColor: UIColor = .white
            static let height: CGFloat = 24
            static let width: CGFloat = 24
        }
    }
    
    static let reuseId: String = "AddHabitCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let habitImageWrap: UIView = UIView()
    private let habitImage: UIImageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureWrap()
        configureHabitImageWrap()
        configureHabitImage()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor, Constants.Wrap.bottomIndent)
        wrap.pinLeft(to: contentView.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinRight(to: contentView.trailingAnchor, Constants.Wrap.trailingIndent)
    }
    
    private func configureHabitImageWrap() {
        wrap.addSubview(habitImageWrap)
        
        habitImageWrap.backgroundColor = Constants.HabitImageWrap.bgColor
        habitImageWrap.layer.cornerRadius = Constants.HabitImageWrap.cornerRadius
        
        habitImageWrap.setHeight(Constants.HabitImageWrap.height)
        habitImageWrap.setWidth(Constants.HabitImageWrap.width)
        
        habitImageWrap.pinCenterX(to: wrap.centerXAnchor)
        habitImageWrap.pinCenterY(to: wrap.centerYAnchor)
    }
    
    private func configureHabitImage() {
        habitImageWrap.addSubview(habitImage)
        
        habitImage.tintColor = Constants.HabitImage.tintColor
        
        habitImage.contentMode = .scaleAspectFill
        habitImage.image = UIImage(systemName: Constants.HabitImage.imageName)
        habitImage.setHeight(Constants.HabitImage.height)
        habitImage.setWidth(Constants.HabitImage.width)
        
        habitImage.pinCenterX(to: habitImageWrap.centerXAnchor)
        habitImage.pinCenterY(to: habitImageWrap.centerYAnchor)
    }
}

