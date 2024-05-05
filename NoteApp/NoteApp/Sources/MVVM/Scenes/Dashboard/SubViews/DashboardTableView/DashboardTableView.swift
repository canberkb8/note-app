//
//  DashboardTableView.swift
//  NoteApp
//
//  Created by Canberk Bibican on 5.05.2024.
//

import UIKit

protocol DashboardTableViewProtocol {
    func update(newItemList: [DashboardModel])
}

protocol DashboardTableViewOutput: AnyObject {
    func onSelected(item: DashboardModel)
}

final class DashboardTableView: NSObject {
    private lazy var itemList: [DashboardModel] = []
    weak var delegate: DashboardTableViewOutput?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = itemList[indexPath.row].name
        cell.detailTextLabel?.text = itemList[indexPath.row].surname
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(item: itemList[indexPath.row])
    }
    
}

extension DashboardTableView: UITableViewDelegate, UITableViewDataSource { }
extension DashboardTableView: DashboardTableViewProtocol {
    func update(newItemList:[DashboardModel]){
        self.itemList = newItemList
    }
}
