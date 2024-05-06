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
    private var router = DashboardRouter()
    private let tableView = UITableView()
    private let dashboardTableView = DashboardTableView()
    private let dashboardViewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        dashboardViewModel.getDashboardList()
    }
    
    private func setup() {
        router.viewController = self
        dashboardViewModel.delegate = self
        setupUI()
        configureTableView()
    }
    
    @objc func addButtonTapped() {
        router.route(identifier: .addEditViewController)
    }
}

extension DashboardViewController: DashboardTableViewOutput {
    func onSelected(item: DashboardModel) {
        print("Selected Item : ", item)
        router.route(identifier: .detailViewController)
    }
    
    func onEdit(item: DashboardModel) {
        router.passEditData(editData: item)
        router.route(identifier: .addEditViewController)
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
        makeNavigationTabBar()
    }
    
    private func makeNavigationTabBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
