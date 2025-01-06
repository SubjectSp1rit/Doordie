//
//  AnalyticsAssembly.swift
//  Doordie
//
//  Created by Arseniy on 06.01.2025.
//

import Foundation
import UIKit

enum AnalyticsAssembly {
    static func build() -> UIViewController {
        let presenter = AnalyticsPresenter()
        let interactor = AnalyticsInteractor(presenter: presenter)
        let view = AnalyticsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
