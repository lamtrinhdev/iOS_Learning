//
//  Application.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 02-December-2021.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application()

    private init() {

    }

    func configureMainInterface(in window: UIWindow) {
        // Init HomeVC and set HomeVC to rootView
        let homeVC = HomeViewController(viewModel: HomeViewModel(service: WeatherWebService()))
        let navigationController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navigationController
    }
}
