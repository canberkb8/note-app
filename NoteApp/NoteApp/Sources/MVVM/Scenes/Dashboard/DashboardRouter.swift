//
//  DashboardRouter.swift
//  NoteApp
//
//  Created by Canberk Bibican on 5.05.2024.
//

import Foundation
import UIKit

enum DashboardRoutingIdentifier: String {
    case detailViewController = "DetailViewController"
    case addEditViewController = "AddEditViewController"
}

protocol DashboardRoutingLogic {
    func route(identifier: DashboardRoutingIdentifier)
    func passEditData(editData: DashboardModel)
}

class DashboardRouter: NSObject, DashboardRoutingLogic {
    weak var viewController: DashboardViewController?
    var destinationVC: UIViewController?
    private lazy var editData: DashboardModel? = nil

    func route(identifier: DashboardRoutingIdentifier) {
        guard let viewController = self.viewController else {
            return
        }
        switch identifier {
        case .detailViewController:
            destinationVC = DetailViewController()
        case .addEditViewController:
            let addEditViewController = AddEditViewController()
            destinationVC = addEditViewController
            if let data = editData {
                addEditViewController.setType(type: .edit)
                addEditViewController.setData(data: data)
            } else {
                addEditViewController.setType(type: .add)
            }
            editData = nil
            if let destinationVC = destinationVC {
                switch identifier {
                case .detailViewController, .addEditViewController:
                    destinationVC.modalPresentationStyle = .fullScreen
                    viewController.navigationController?.pushViewController(destinationVC, animated: true)
                }
            }
        }
    }

    func passEditData(editData: DashboardModel) {
        self.editData = editData
    }
}
