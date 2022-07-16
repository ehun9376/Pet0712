//
//  SearchConditionsCell.swift
//  Pet
//
//  Created by yihuang on 2022/7/16.
//

import Foundation
import UIKit

class SearchConditionsCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "SearchConditionsCell"
    }
    
    var conditionsTitle: String? = ""
    
    var detailText: String? = ""
    
    var detailData: Any?
    
    init(
        conditionsTitle: String? = "",
        detailText: String? = "",
        detailData: Any? = nil,
        cellAction: ((CellRowModel)->())? = nil
    ){
        super.init()
        self.conditionsTitle = conditionsTitle
        self.detailText = detailText
        self.detailData = detailData
        self.cellDidSelect = cellAction
    }
}

class SearchConditionsCell: UITableViewCell {
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        
    }
    
}

extension SearchConditionsCell: CellViewBase {
    
    func setupCellView(rowModel: CellRowModel) {
        
        guard let rowModel = rowModel as? SearchConditionsCellRowModel else { return }
        
        self.conditionLabel.text = rowModel.conditionsTitle
        
        self.detailLabel.text = rowModel.detailText
        
    }
}
