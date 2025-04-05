//
//  ProfileFriendCell.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

protocol ProfileCellDelegate: AnyObject {
    func profileCellDidTriggerDelete(_ cell: ProfileFriendCell)
}

final class ProfileFriendCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Cell {
            static let bgColor: UIColor = .clear
        }
        
        enum ContentView {
            static let bgColor: UIColor = .clear
        }
        
        enum Wrap {
            static let height: CGFloat = 100
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let trailingIndent: CGFloat = 18
            static let bottomIndent: CGFloat = 10
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOpacity: Float = 0.5
            static let shadowOffsetX: CGFloat = 0
            static let shadowOffsetY: CGFloat = 4
            static let shadowRadius: CGFloat = 8
        }
        
        enum ProfileImage {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let cornerRadius: CGFloat = 35
            static let imageSide: CGFloat = 70
            static let leadingIndent: CGFloat = 14
        }
        
        enum NameLabel {
            static let textAlignment: NSTextAlignment = .left
            static let textColor: UIColor = .white
            static let numberOfLines: Int = 1
            static let leadingIndent: CGFloat = 8
        }
        
        enum ChevronRight {
            static let imageName: String = "chevron.right"
            static let trailingIndent: CGFloat = 12
            static let tintColor: UIColor = .white
        }
        
        enum Swipe {
            static let deleteThreshold: CGFloat = 80 // При этом сдвиге ячейка удаляется
            static let animationDuration: TimeInterval = 0.3
            static let deleteButtonWidth: CGFloat = 80 // Максимальная ширина delete‑view
            static let deleteButtonRightIndent: CGFloat = 18
            static let iconRevealThreshold: CGFloat = 40 // При этом значении ширины иконка начинает появляться
        }
    }
    
    static let reuseId: String = "ProfileFriendCell"
    
    // MARK: - UI Components
    private let wrap: UIView = UIView()
    private let profileImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let chevronRight: UIImageView = UIImageView()
    
    private let customContentView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.ContentView.bgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Вьюшка, отображающая красный фон с иконкой мусорного бака, которая появится при свайпе
    private let deleteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let trashIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "trash")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    // MARK: - Properties
    weak var delegate: ProfileCellDelegate?
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    /// Исходное положение customContentView, сохранённое при начале свайпа
    private var originalCenter: CGPoint = .zero
    /// Ширина delete‑view, изменяется динамически при свайпе
    private var deleteViewWidthConstraint: NSLayoutConstraint!
    /// Tap-жест для нажатия на красную вью
    private var deleteTapGesture: UITapGestureRecognizer?
    private var startingTranslation: CGFloat = 0
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customContentView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        deleteViewWidthConstraint.constant = 0
        trashIcon.alpha = 0
        removeDeleteTapGesture()
    }
    
    // MARK: - Methods
    func configure(with friend: ProfileModels.FriendUser) {
        nameLabel.text = friend.name
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.Cell.bgColor
        contentView.backgroundColor = Constants.ContentView.bgColor
        contentView.layer.masksToBounds = false
        
        configureSwipeViews()
        addPanGesture()
        addDeleteTapGesture()
        
        configureWrap()
        configureProfileImage()
        configureNameLabel()
        configureChevronRight()
    }
    
    private func configureSwipeViews() {
        contentView.addSubview(deleteBackgroundView)
        NSLayoutConstraint.activate([
            deleteBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            deleteBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Swipe.deleteButtonRightIndent)
        ])
        deleteViewWidthConstraint = deleteBackgroundView.widthAnchor.constraint(equalToConstant: 0)
        deleteViewWidthConstraint.isActive = true
        
        deleteBackgroundView.addSubview(trashIcon)
        NSLayoutConstraint.activate([
            trashIcon.centerXAnchor.constraint(equalTo: deleteBackgroundView.centerXAnchor),
            trashIcon.centerYAnchor.constraint(equalTo: deleteBackgroundView.centerYAnchor),
            trashIcon.widthAnchor.constraint(equalToConstant: 24),
            trashIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        contentView.addSubview(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func configureWrap() {
        customContentView.addSubview(wrap)
        
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
    
    private func configureProfileImage() {
        wrap.addSubview(profileImage)
        
        profileImage.layer.cornerRadius = Constants.ProfileImage.cornerRadius
        profileImage.contentMode = Constants.ProfileImage.contentMode
        profileImage.clipsToBounds = true
        
        profileImage.image = UIImage(named: "profileImage")
        
        profileImage.pinLeft(to: wrap.leadingAnchor, Constants.ProfileImage.leadingIndent)
        profileImage.pinCenterY(to: wrap.centerYAnchor)
        profileImage.setWidth(Constants.ProfileImage.imageSide)
        profileImage.setHeight(Constants.ProfileImage.imageSide)
    }
    
    private func configureNameLabel() {
        wrap.addSubview(nameLabel)
        
        nameLabel.textColor = Constants.NameLabel.textColor
        nameLabel.textAlignment = Constants.NameLabel.textAlignment
        nameLabel.numberOfLines = Constants.NameLabel.numberOfLines
        
        nameLabel.pinCenterY(to: wrap.centerYAnchor)
        nameLabel.pinLeft(to: profileImage.trailingAnchor, Constants.NameLabel.leadingIndent)
    }
    
    private func configureChevronRight() {
        wrap.addSubview(chevronRight)
        
        chevronRight.image = UIImage(systemName: Constants.ChevronRight.imageName)
        chevronRight.tintColor = Constants.ChevronRight.tintColor
        
        chevronRight.pinCenterY(to: wrap.centerYAnchor)
        chevronRight.pinRight(to: wrap.trailingAnchor, Constants.ChevronRight.trailingIndent)
    }
    
    private func addPanGesture() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    private func addDeleteTapGesture() {
        if deleteTapGesture == nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleDeleteTap(_:)))
            deleteBackgroundView.addGestureRecognizer(tap)
            deleteBackgroundView.isUserInteractionEnabled = true
            deleteTapGesture = tap
        }
    }
    
    private func removeDeleteTapGesture() {
        if let tap = deleteTapGesture {
            deleteBackgroundView.removeGestureRecognizer(tap)
            deleteTapGesture = nil
        }
    }
    
    // MARK: - Actions
    @objc private func handleDeleteTap(_ gesture: UITapGestureRecognizer) {
        // По тапу на красную вью вызываем делегата для удаления ячейки
        delegate?.profileCellDidTriggerDelete(self)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .began:
            // Сохраняем текущее смещение (transform.tx) в момент начала жеста
            startingTranslation = customContentView.transform.tx
            
        case .changed:
            // Вычисляем общее смещение с учётом уже установленного смещения
            let totalTranslation = startingTranslation + translation.x
            // Не допускаем движения вправо: если totalTranslation > 0, то обнуляем
            let clampedTranslation = min(totalTranslation, 0)
            // Ограничиваем максимальное смещение влево (например, -deleteButtonWidth)
            let finalTranslation = max(clampedTranslation, -Constants.Swipe.deleteButtonWidth)
            
            customContentView.transform = CGAffineTransform(translationX: finalTranslation, y: 0)
            
            let deltaX = abs(finalTranslation)
            deleteViewWidthConstraint.constant = deltaX
            
            let iconAlpha: CGFloat = deltaX < Constants.Swipe.iconRevealThreshold
                ? 0
                : min(1, (deltaX - Constants.Swipe.iconRevealThreshold) / (Constants.Swipe.deleteButtonWidth - Constants.Swipe.iconRevealThreshold))
            trashIcon.alpha = iconAlpha
            
            layoutIfNeeded()
            
        case .ended, .cancelled:
            // Если общее смещение (по модулю) достигло порога, фиксируем положение
            let currentTranslation = abs(customContentView.transform.tx)
            if currentTranslation >= Constants.Swipe.deleteThreshold {
                UIView.animate(withDuration: Constants.Swipe.animationDuration, animations: {
                    self.customContentView.transform = CGAffineTransform(translationX: -Constants.Swipe.deleteButtonWidth, y: 0)
                    self.deleteViewWidthConstraint.constant = Constants.Swipe.deleteButtonWidth
                    self.trashIcon.alpha = 1
                    self.layoutIfNeeded()
                })
                self.addDeleteTapGesture()
            } else {
                UIView.animate(withDuration: Constants.Swipe.animationDuration, animations: {
                    self.customContentView.transform = .identity
                    self.deleteViewWidthConstraint.constant = 0
                    self.trashIcon.alpha = 0
                    self.layoutIfNeeded()
                })
                self.removeDeleteTapGesture()
            }
            
        default:
            break
        }
    }
}
