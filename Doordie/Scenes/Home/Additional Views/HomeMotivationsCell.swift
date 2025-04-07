//
//  HomeMotivationsCell.swift
//  Doordie
//
//  Created by Arseniy on 07.04.2025.
//

import UIKit

final class HomeMotivationsCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 90
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
            static let masksToBounds: Bool = false
        }
        
        enum CloseButton {
            static let imageName: String = "xmark"
            static let tintColor: UIColor = .systemGray.withAlphaComponent(0.7)
            static let topIndent: CGFloat = 10
            static let trailingIndent: CGFloat = 10
            static let size: CGFloat = 20
        }
        
        enum PercentageLabel {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
            static let font = UIFont.systemFont(ofSize: 32, weight: .semibold)
            static let leadingIndent: CGFloat = 36
        }
        
        enum HeaderLabel {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 3
            static let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        enum DescLabel {
            static let textColor: UIColor = UIColor(hex: "B3B3B3")
            static let textAlignment: NSTextAlignment = .left
            static let numberOfLines: Int = 3
            static let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        
        enum Stack {
            static let axis: NSLayoutConstraint.Axis = .vertical
            static let spacing: CGFloat = 6
            static let alignment: UIStackView.Alignment = .leading
            static let distribution: UIStackView.Distribution = .fillEqually
            static let leadingIndent: CGFloat = 24
        }
    }
    
    static let reuseId: String = "HomeMotivationsCell"
    
    // MARK: - UI Components
    private let wrap: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Wrap.bgColor
        view.layer.cornerRadius = Constants.Wrap.cornerRadius
        view.layer.shadowColor = Constants.Wrap.shadowColor
        view.layer.shadowOpacity = Constants.Wrap.shadowOpacity
        view.layer.shadowOffset = CGSize(width: Constants.Wrap.shadowOffsetX, height: Constants.Wrap.shadowOffsetY)
        view.layer.shadowRadius = Constants.Wrap.shadowRadius
        view.layer.masksToBounds = Constants.Wrap.masksToBounds
        return view
    }()
    
    private let closeButton: ExtendedHitButton = {
        let button = ExtendedHitButton()
        button.setImage(UIImage(systemName: Constants.CloseButton.imageName), for: .normal)
        button.tintColor = Constants.CloseButton.tintColor
        return button
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.PercentageLabel.textColor
        label.textAlignment = Constants.PercentageLabel.textAlignment
        label.font = Constants.PercentageLabel.font
        return label
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.HeaderLabel.textColor
        label.textAlignment = Constants.HeaderLabel.textAlignment
        label.font = Constants.HeaderLabel.font
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.DescLabel.textColor
        label.textAlignment = Constants.DescLabel.textAlignment
        label.font = Constants.DescLabel.font
        label.numberOfLines = Constants.DescLabel.numberOfLines
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = Constants.Stack.axis
        stack.spacing = Constants.Stack.spacing
        stack.alignment = Constants.Stack.alignment
        stack.distribution = Constants.Stack.distribution
        return stack
    }()
    
    // MARK: - Properties
    var onCloseButtonTapped: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(percentage: String, header: String, description: String) {
        percentageLabel.text = percentage
        headerLabel.text = header
        descLabel.text = description
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        contentView.addSubview(wrap)
        wrap.addSubview(closeButton)
        wrap.addSubview(percentageLabel)
        wrap.addSubview(stack)
        stack.addArrangedSubview(headerLabel)
        stack.addArrangedSubview(descLabel)
    }
    
    private func configureConstraints() {
        wrap.setHeight(Constants.Wrap.height)
        wrap.pinTop(to: contentView.topAnchor)
        wrap.pinBottom(to: contentView.bottomAnchor)
        wrap.pinLeft(to: contentView.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinRight(to: contentView.trailingAnchor, Constants.Wrap.trailingIndent)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.setHeight(Constants.CloseButton.size)
        closeButton.setWidth(Constants.CloseButton.size)
        closeButton.pinTop(to: wrap.topAnchor, Constants.CloseButton.topIndent)
        closeButton.pinRight(to: wrap.trailingAnchor, Constants.CloseButton.trailingIndent)
        
        percentageLabel.pinCenterY(to: wrap.centerYAnchor)
        percentageLabel.pinLeft(to: wrap.leadingAnchor, Constants.PercentageLabel.leadingIndent)
        
        stack.pinCenterY(to: wrap.centerYAnchor)
        stack.pinLeft(to: percentageLabel.trailingAnchor, Constants.Stack.leadingIndent)
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
        onCloseButtonTapped?()
    }
}
