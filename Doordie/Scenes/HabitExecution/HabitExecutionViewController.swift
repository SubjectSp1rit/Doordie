//
//  HabitExecutionViewController.swift
//  Doordie
//
//  Created by Arseniy on 03.02.2025.
//

import UIKit

final class HabitExecutionViewController: UIViewController {
    // MARK: - Variables
    private var interactor: HabitExecutionBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: HabitExecutionBusinessLogic) {
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
