//
//  WelcomeViewController.swift
//  Doordie
//
//  Created by Arseniy on 22.02.2025.
//

import UIKit

final class WelcomeViewController: UIViewController {
    // MARK: - Variables
    private var interactor: WelcomeBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: WelcomeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
