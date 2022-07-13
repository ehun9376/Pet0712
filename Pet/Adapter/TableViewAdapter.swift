//
//  TableViewAdapter.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/12.
//

import Foundation
import UIKit


protocol CellViewBase {
    func setupCellView(rowModel: CellRowModel)
}

protocol CellRowModelBase {
    func cellReUseID() -> String
}


class CellRowModel: CellRowModelBase {
    func cellReUseID() -> String {
        fatalError("Need Override ")
    }
    var cellDidSelect: ((CellRowModel)->())?
    var indexPath: IndexPath?
    weak var tableView: UITableView?
    
    func updateCellView() {
        if let tableView = tableView {
            tableView.reloadRows(at: [self.indexPath ?? IndexPath()], with: .none)
        }
    }
}


class TableViewAdapter: NSObject {
    
    var tableView: UITableView?
    
    var rowModels: [CellRowModel] = []
    
    init(_ tableView: UITableView){
        super.init()
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    func updateTableViewData(rowModels : [CellRowModel]) {
        
        self.rowModels = rowModels
        
        DispatchQueue.main.async {
            self.tableView?.reloadData()

        }
    }
    
}
extension TableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.rowModels[indexPath.row].indexPath = indexPath
        self.rowModels[indexPath.row].tableView = tableView
        let rowModel = self.rowModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: rowModel.cellReUseID(), for: indexPath)
        if let cell = cell as? CellViewBase {
            cell.setupCellView(rowModel: rowModel)
        }
        return cell
    }
    
    
}
extension TableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowModel = self.rowModels[indexPath.row]
        if let action = rowModel.cellDidSelect {
            action(rowModel)
        }
    }
}
