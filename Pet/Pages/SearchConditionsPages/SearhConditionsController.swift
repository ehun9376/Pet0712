//
//  SearhConditionsController.swift
//  Pet
//
//  Created by yihuang on 2022/7/16.
//

import Foundation

class SearchPetConditions: Equatable {
    static func == (lhs: SearchPetConditions, rhs: SearchPetConditions) -> Bool {
        return lhs.petType == rhs.petType &&
        lhs.sex == rhs.sex
    }
    
    
    var petType: SelectData = .pleaseSelect
    
    var sex: SelectData = .pleaseSelect
    
}

class SearhConditionsController: BaseTableViewController {
    
    var searchPetConditions = SearchPetConditions()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRegisID(cellIDs: [
            "SearchConditionsCell"
        ])
        self.setupRow()
    }

    func setupRow() {
        
        var rowModels: [CellRowModel] = []
        
        let petTypeRow = SearchConditionsCellRowModel(conditionsTitle: "動物類別:",
                                                      detailText: self.searchPetConditions.petType.title,
                                                      detailData: self.searchPetConditions.petType)
        petTypeRow.cellDidSelect = { rowModels in
            self.gotoSelectConditionsVC(selectType: .single,
                                        dataSource: SelectData.petTypeConditios(),
                                        selectedData: [self.searchPetConditions.petType],
                                        confirmAction: { returnDatas in
                if let returnDatas = returnDatas as? [SelectData],
                   let data = returnDatas.first {
                    self.searchPetConditions.petType = data
                }
                self.setupRow()
            })
        }
        
        rowModels.append(petTypeRow)
        
        let sexRow = SearchConditionsCellRowModel(conditionsTitle: "性別:",
                                                  detailText: self.searchPetConditions.sex.title,
                                                  detailData: self.searchPetConditions.sex)
        sexRow.cellDidSelect = { rowModels in
            self.gotoSelectConditionsVC(selectType: .multiple,
                                        dataSource: SelectData.sexConditions(),
                                        selectedData: [self.searchPetConditions.sex],
                                        confirmAction: { returnDatas in
                if let returnDatas = returnDatas as? [SelectData],
                   let returnData = returnDatas.first {
                    self.searchPetConditions.sex = returnData
                }
                self.setupRow()
            })
        }
        
        rowModels.append(sexRow)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
        
    }
    
    func gotoSelectConditionsVC(selectType: SelectType ,dataSource: [Any], selectedData: [Any],confirmAction: (([Any])->())?) {
        let vc = SelectConditionsController(selectType: selectType,
                                            dataSource: dataSource,
                                            selectedData: selectedData,
                                            confirmAction: confirmAction)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    override func createBottomBarViewModel() -> BottomBarViewModel {
        
        let search: BottomBarButtonModel = .search(style: .white) {
            let vc = PetTableViewController()
            vc.searchPetConditions = self.searchPetConditions
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let viewModel = StackBottomBarViewModel(backgroundColor: .white, buttonsModels: [search])
        
        return viewModel
    }
    
}
