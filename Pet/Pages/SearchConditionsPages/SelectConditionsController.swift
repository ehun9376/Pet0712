//
//  SelectConditionsController.swift
//  Pet
//
//  Created by yihuang on 2022/7/16.
//

import Foundation



class SelectData: Equatable {
    static func == (lhs: SelectData, rhs: SelectData) -> Bool {
        return lhs.title == rhs.title &&
        lhs.index == rhs.index
    }
    init(
        title: String = "",
        index: Int = 0
    ){
        self.title = title
        self.index = index
    }
    
    var title: String = ""
    
    var index: Int = 0
    
    static let pleaseSelect = SelectData(title: "請選擇", index: 999)
    
    static func sexConditions() -> [SelectData]{
        return[.init(title: "公", index: 0),.init(title: "母", index: 1)]
    }
    
    static func petTypeConditios() -> [SelectData]{
        return[.init(title: "狗", index: 0),.init(title: "貓", index: 1)]
    }
    
}


enum SelectType {
    case single
    case multiple
}

class SelectConditionsController<dataSourceType,selectedDataType>: BaseTableViewController {

    
    var selectType: SelectType = .single
    
    var dataSource: dataSourceType
    
    var selectedData: selectedDataType
    
    var confirmAction: ((selectedDataType)->())?
    
    init(
        selectType: SelectType = .single,
        dataSource: dataSourceType ,
        selectedData: selectedDataType,
        confirmAction: ((selectedDataType)->())?
    ){
        self.selectType = selectType
        self.dataSource = dataSource
        self.selectedData = selectedData
        self.confirmAction = confirmAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRow()
    }
    override func regisCellID() {
        self.defaultTableView.register(SelectConditionsCell.self, forCellReuseIdentifier: "SelectConditionsCell")
    }
    
    func setupRow(){
        
        self.rowModels.removeAll()
        if let _source = self.dataSource as? [SelectData],
           var _selectedData = self.selectedData as? [SelectData] {
            for data in _source {
                self.rowModels.append(SelectConditionsCellRowModel(text:data.title,
                                                                   selectData: data,
                                                                   isSelect: _selectedData.contains(data),
                                                                   cellAction: { rowModel in
                    guard let rowModel = rowModel as? SelectConditionsCellRowModel else { return }
                    
                    switch self.selectType {
                    case .single:
                        _selectedData.removeAll()
                        _selectedData.append(rowModel.selectData as? SelectData ?? .init())
                    case .multiple:
                        if _selectedData.contains(rowModel.selectData as? SelectData ?? .init()) {
                            _selectedData = _selectedData.filter({ selectedData in
                                selectedData != data
                            })
                        } else {
                            _selectedData.append(rowModel.selectData as? SelectData ?? .init())
                        }
                    }
                    guard let _selectedData  = _selectedData as? selectedDataType else { return }
                    self.selectedData = _selectedData
                }))
            }
        }
        
        self.adapter?.updateTableViewData(rowModels: self.rowModels)
    }
    
    override func setBottomButtons() -> [BottomBarButton] {
        let confirmButton: BottomBarButton = .confirm {
            if let _confirmAction = self.confirmAction{
                _confirmAction(self.selectedData)
            }
            self.navigationController?.popViewController(animated: true)
        }
        return [confirmButton]
    }
    
}
    
