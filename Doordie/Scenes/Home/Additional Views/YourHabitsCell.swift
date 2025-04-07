//
//  YourHabitsCell.swift
//  Doordie
//
//  Created by Arseniy on 07.04.2025.
//

import UIKit

final class YourHabitsCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum YourHabitsLabel {
            static let text: String = "Your habits"
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let font: UIFont = .systemFont(ofSize: 22, weight: .regular)
            static let leadingIndent: CGFloat = 18
        }
    }
    
    static let reuseId: String = "YourHabitsCell"
    
    // MARK: - UI Components
    private let yourHabitsLabel: UILabel = UILabel()
    
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
        
        configureYourHabitsLabel()
    }
    
    private func configureYourHabitsLabel() {
        contentView.addSubview(yourHabitsLabel)
        
        yourHabitsLabel.text = Constants.YourHabitsLabel.text
        yourHabitsLabel.textAlignment = Constants.YourHabitsLabel.textAlignment
        yourHabitsLabel.textColor = Constants.YourHabitsLabel.textColor
        yourHabitsLabel.font = Constants.YourHabitsLabel.font
        
        yourHabitsLabel.pinTop(to: contentView.topAnchor)
        yourHabitsLabel.pinBottom(to: contentView.bottomAnchor)
        yourHabitsLabel.pinLeft(to: contentView.leadingAnchor, Constants.YourHabitsLabel.leadingIndent)
    }
}
