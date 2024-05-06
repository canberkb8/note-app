//
//  SplashRouter.swift
//  NoteApp
//
//  Created by Canberk Bibican on 5.05.2024.
//

import Foundation
import UIKit

enum SplashRoutingIdentifier: String {
    case dashboardViewController = "DashboardViewController"
}

protocol SplashRoutingLogic {
    func route(identifier: SplashRoutingIdentifier)
}

class SplashRouter: NSObject, SplashRoutingLogic {
    weak var viewController: SplashViewController?
    var destinationVC: UIViewController?

    func route(identifier: SplashRoutingIdentifier) {
        guard let viewController = self.viewController else {
            return
        }
        switch identifier {
        case .dashboardViewController:
            destinationVC = DashboardViewController()
        }
        if let destinationVC = destinationVC {
            switch identifier {
            case .dashboardViewController:
                let navController = UINavigationController(rootViewController: destinationVC)
                navController.modalPresentationStyle = .fullScreen
                navController.modalTransitionStyle = .crossDissolve
                viewController.present(navController, animated: true, completion: nil)
            }
        }
    }
}
