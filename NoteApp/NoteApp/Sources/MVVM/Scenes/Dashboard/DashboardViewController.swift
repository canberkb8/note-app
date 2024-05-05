//
//  DashboardViewController.swift
//  NoteApp
//
//  Created by Canberk Bibican on 5.05.2024.
//

import UIKit

protocol DashboardViewControllerProtocol: AnyObject {
    func DashboardDataSuccess()
    func DashboardDataError(error: String)
}

class DashboardViewController: BaseViewController {
    
    private let tableView = UITableView()
    private let dashboardTableView = DashboardTableView()
    private let dashboardViewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        dashboardViewModel.getDashboardList()
    }
    
    private func setup() {
        dashboardViewModel.delegate = self
        setupUI()
        configureTableView()
    }
}

extension DashboardViewController: DashboardTableViewOutput {
    func onSelected(item: DashboardModel) {
        print("Selected Item : ", item)
    }
}

extension DashboardViewController: DashboardViewControllerProtocol {
    func DashboardDataSuccess() {
        print("DashboardList : ", dashboardViewModel.dashboardList ?? [])
        dashboardTableView.update(newItemList: dashboardViewModel.dashboardList ?? [])
        tableView.reloadData()
    }
    
    func DashboardDataError(error: String) {
        
    }
}

extension DashboardViewController {
    
    private func configureTableView() {
        tableView.delegate = dashboardTableView
        tableView.dataSource = dashboardTableView
        dashboardTableView.delegate = self
    }
    
    private func setupUI() {
        makeTableView()
    }
    
    private func makeTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
