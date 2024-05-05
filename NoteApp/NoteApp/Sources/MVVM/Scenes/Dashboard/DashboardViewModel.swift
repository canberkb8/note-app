//
//  DashboardViewModel.swift
//  NoteApp
//
//  Created by Canberk Bibican on 5.05.2024.
//

import Foundation

protocol DashboardViewModelLogic {
    func getDashboardList()
}

protocol DashboardViewModelDataStore {
    var dashboardList: [DashboardModel]? {get set}
}

final class DashboardViewModel: DashboardViewModelLogic, DashboardViewModelDataStore {
    
    weak var delegate: DashboardViewControllerProtocol?
    var dashboardList: [DashboardModel]?
    
    func getDashboardList() {
        dashboardList = [
            DashboardModel(name: "Canberk", surname: "Bibican"),
            DashboardModel(name: "Ekin Barış", surname: "Demir"),
            DashboardModel(name: "Definex", surname: "Mobil Team"),
            DashboardModel(name: "Swift", surname: "UI & Unit Test Training")
        ]
        if let dashboardList = dashboardList, !dashboardList.isEmpty {
            delegate?.DashboardDataSuccess()
        } else {
            delegate?.DashboardDataError(error: "Error")
        }
    }
    
}
