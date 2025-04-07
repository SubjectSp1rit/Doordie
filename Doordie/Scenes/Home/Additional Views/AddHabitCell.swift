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
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
        enum AddImage {
            static let imageName: String = "plus"
            static let tintColor: UIColor = .white
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let imageSide: CGFloat = 25
        }
        
        enum AddHabitLabel {
            static let text: String = "Add first habit..."
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let numberOfLines: Int = 1
        }
        
        enum Stack {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let spacing: CGFloat = 12
            static let alignment: UIStackView.Alignment = .center
        }
    }
    
    static let reuseId: String = "AddHabitCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let addImage: UIImageView = UIImageView()
    private let addHabitLabel: UILabel = UILabel()
    private let stack: UIStackView = UIStackView()
    
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
        configureAddImage()
        configureAddHabitLabel()
        configureStack()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        
        // Тень
        wrap.layer.shadowColor = Constants.Wrap.shadowColor
        wrap.layer.shadowOpacity = Constants.Wrap.shadowOpacity
        wrap.layer.shadowOffset = CGSize(width: Constants.Wrap.shadowOffsetX, height: Constants.Wrap.shadowOffsetY)
        wrap.layer.shadowRadius = Constants.Wrap.shadowRadius
        wrap.layer.masksToBounds = false
        
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor, Constants.Wrap.bottomIndent)
        wrap.pinLeft(to: contentView.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinRight(to: contentView.trailingAnchor, Constants.Wrap.trailingIndent)
    }
    
    private func configureAddImage() {
        wrap.addSubview(addImage)
        
        addImage.image = UIImage(systemName: Constants.AddImage.imageName)
        addImage.tintColor = Constants.AddImage.tintColor
        addImage.contentMode = Constants.AddImage.contentMode
        addImage.clipsToBounds = true
        
        addImage.setWidth(Constants.AddImage.imageSide)
        addImage.setHeight(Constants.AddImage.imageSide)
    }
    
    private func configureAddHabitLabel() {
        wrap.addSubview(addHabitLabel)
        
        addHabitLabel.text = Constants.AddHabitLabel.text
        addHabitLabel.textColor = Constants.AddHabitLabel.textColor
        addHabitLabel.textAlignment = Constants.AddHabitLabel.textAlignment
        addHabitLabel.numberOfLines = Constants.AddHabitLabel.numberOfLines
    }
    
    private func configureStack() {
        wrap.addSubview(stack)
        
        stack.axis =  Constants.Stack.axis
        stack.spacing = Constants.Stack.spacing
        stack.alignment = Constants.Stack.alignment
        
        stack.addArrangedSubview(addImage)
        stack.addArrangedSubview(addHabitLabel)
        
        stack.pinCenterY(to: wrap.centerYAnchor)
        stack.pinCenterX(to: wrap.centerXAnchor)
    }
}

