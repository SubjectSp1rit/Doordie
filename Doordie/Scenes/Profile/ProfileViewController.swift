//
//  ProfileViewController.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Background {
            static let imageName: String = "ultramarineBackground"
        }
        
        enum NavBar {
            static let title: String = "Profile"
            static let tintColor: UIColor = .white
        }
        
        enum Wrap {
            static let bgColor: UIColor = UIColor(hex: "3A50C2").withAlphaComponent(0.6)
            static let cornerRadius: CGFloat = 20
            static let leadingIndent: CGFloat = 18
            static let topIndent: CGFloat = 100
        }
        
        enum ProfileImage {
            static let contentMode: UIView.ContentMode = .scaleAspectFill
            static let cornerRadius: CGFloat = 75
            static let imageSide: CGFloat = 150
        }
        
        enum NameLabel {
            static let textColor: UIColor = .white
            static let textAlignment: NSTextAlignment = .center
            static let fontSize: CGFloat = 48
            static let fontWeigth: UIFont.Weight = .semibold
            static let topIndent: CGFloat = 12
        }
    }
    
    // MARK: - UI Components
    private let background: UIImageView = UIImageView()
    private let wrap: UIView = UIView()
    private let profileImage: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    
    // MARK: - Properties
    private var interactor: ProfileBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: ProfileBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureNavBar()
        configureWrap()
        configureProfileImage()
        configureNameLabel()
    }
    
    private func configureBackground() {
        view.addSubview(background)
        
        background.image = UIImage(named: Constants.Background.imageName)
        background.pin(to: view)
                
        // Размытие заднего фона
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        
        blurEffectView.pin(to: view)
    }
    
    private func configureNavBar() {
        navigationItem.title = Constants.NavBar.title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.NavBar.tintColor]
    }
    
    private func configureWrap() {
        view.addSubview(wrap)
        
        wrap.backgroundColor = Constants.Wrap.bgColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrap.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        wrap.pinCenterX(to: view.centerXAnchor)
        wrap.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.Wrap.leadingIndent)
        wrap.pinBottom(to: view.bottomAnchor)
        wrap.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.Wrap.topIndent)
    }
    
    private func configureProfileImage() {
        view.addSubview(profileImage)
        
        profileImage.contentMode = Constants.ProfileImage.contentMode
        profileImage.layer.cornerRadius = Constants.ProfileImage.cornerRadius
        profileImage.clipsToBounds = true
        profileImage.setWidth(Constants.ProfileImage.imageSide)
        profileImage.setHeight(Constants.ProfileImage.imageSide)
        
        // temp
        profileImage.image = UIImage(named: "profileImage")
        
        profileImage.pinCenterX(to: wrap.centerXAnchor)
        profileImage.pinCenterY(to: wrap.topAnchor)
    }
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.text = "User"
        nameLabel.textAlignment = Constants.NameLabel.textAlignment
        nameLabel.font = UIFont.systemFont(ofSize: Constants.NameLabel.fontSize, weight: Constants.NameLabel.fontWeigth)
        nameLabel.textColor = Constants.NameLabel.textColor
        
        nameLabel.pinCenterX(to: wrap.centerXAnchor)
        nameLabel.pinTop(to: profileImage.bottomAnchor, Constants.NameLabel.topIndent)
    }
}
