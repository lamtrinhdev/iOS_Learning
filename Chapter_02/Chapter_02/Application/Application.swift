//
//  Application.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 02-December-2021.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application()

    private init() { }

    func configureMainInterface(in window: UIWindow) {
        let homeUseCase = UseCaseProvider().makeHomeUseCase()
        let homeVC = HomeViewController(useCase: homeUseCase)
        let navigateController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navigateController
        window.makeKeyAndVisible()
    }
}
