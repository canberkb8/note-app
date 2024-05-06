//
//  AddEditViewController.swift
//  NoteApp
//
//  Created by definex_mobile2 on 6.05.2024.
//

import UIKit

protocol AddEditViewControllerDataStore {
    func setType(type: AddEditType)
    func setData(data: DashboardModel)
}

enum AddEditType {
    case add, edit
}

class AddEditViewController: BaseViewController {
    private lazy var pageType: AddEditType? = nil
    private lazy var editModel: DashboardModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("Page Type : ", pageType)
        print("Dashboard Model : ", editModel)
    }

}

extension AddEditViewController: AddEditViewControllerDataStore {
    func setType(type: AddEditType) {
        pageType = type
    }

    func setData(data: DashboardModel) {
        editModel = data
    }
}
