//
//  TableViewCellBase.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/12.
//

import Foundation


protocol CellViewBase {
    func setupCellView(rowModel: CellRowModel)
}

protocol CellRowModelBase {
    func cellReUseID() -> String
}


class CellRowModel: CellRowModelBase {
    func cellReUseID() -> String {
        return ""
    }
    var cellDidSelect: ((CellRowModel)->())?
    var indexPath: IndexPath?
}
