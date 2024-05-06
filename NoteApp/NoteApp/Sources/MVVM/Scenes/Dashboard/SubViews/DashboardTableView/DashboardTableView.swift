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
    func onEdit(item: DashboardModel)
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Remove") { [weak self] (_, indexPath) in
            guard let self = self else { return }
            self.removeItem(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = UIColor(rgb: 0xf16a6f)
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { [weak self] (_, indexPath) in
            guard let self = self else { return }
            self.delegate?.onEdit(item: itemList[indexPath.row])
        }
        editAction.backgroundColor = UIColor(rgb: 0xf8b014)
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension DashboardTableView: UITableViewDelegate, UITableViewDataSource { }
extension DashboardTableView: DashboardTableViewProtocol {
    func update(newItemList: [DashboardModel]) {
        self.itemList = newItemList
    }
    
    func removeItem(at indexPath: IndexPath) {
        self.itemList.remove(at: indexPath.row)
    }
}
