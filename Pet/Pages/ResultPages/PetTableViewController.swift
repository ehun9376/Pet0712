//
//  PetTableViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit

import UIKit
import SDWebImage
class PetTableViewController: BaseTableViewController {

    var searchPetConditions = SearchPetConditions()
        
    var petList: [PetModel] = []
    
    var lovePetList: [PetModel] = []
    
    
    override func viewDidLoad() {
        self.defaultBottomBarHeight = self.view.safeAreaInsets.bottom
        super.viewDidLoad()
        self.downLoadAPI()
        self.adapter?.reachBottomAction = { _ in
            self.downLoadAPI()
        }
    }
    
    override func setRegisID() -> [String] {
        return [
            "PetTableViewCell"
        ]
    }
    
    func downLoadAPI() {
        NetworkService.downloadJson() { result in
            switch result {
            case .success(let data):
                self.petList.append(contentsOf: data)
                self.setupRow()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filterData(petList: [PetModel] = []) -> [PetModel] {
        var tempPetList = petList
        
        
        
        if self.searchPetConditions.petType != .pleaseSelect {
            tempPetList = tempPetList.filter({ petModel in
                petModel.animalKind == self.searchPetConditions.petType.title
            })
        }
        
       
        
        
        if self.searchPetConditions.sex != .pleaseSelect {
            let sexCode = self.searchPetConditions.sex.title == "公" ? "M" : "F"
            tempPetList = tempPetList.filter({ petModel in
                petModel.animalSex == sexCode
            })
        }
        

        return tempPetList
    }
    
    func setupRow() {

        
        
        self.getLoveList()
        var rowModels: [CellRowModel] = []
        let sortFilterList = self.filterData(petList: self.petList)
        
        for pet in sortFilterList {
            let petTableViewCellRowModel = PetTableViewCellRowModel(lableTitle: pet.animalVariety,
                                                                    imageURLStr: pet.albumFile,
                                                                    isLove: self.lovePetList.contains(pet),
                                                                    petModel: pet,
                                                                    shareButtonAction: { petVariety,petImage in
                              self.showShareVC(petVariety: petVariety, petImage: petImage)
                          },
                                                                    cellAction: { rowModel in
                              guard  let rowModel =  rowModel as? PetTableViewCellRowModel else { return }
                              self.gotoPetDetailVC(petModel: rowModel.petModel)
                          })
            
            petTableViewCellRowModel.loveButtonAction = { petModel in
                if self.lovePetList.contains(petModel) {
                    self.lovePetList = self.lovePetList.filter { lovedpetModel in
                        lovedpetModel != petModel
                    }
                } else {
                    self.lovePetList.append(petModel)
                }
                self.setLoveList()
                petTableViewCellRowModel.isLove.toggle()
                petTableViewCellRowModel.updateCellView()
            }
            rowModels.append(petTableViewCellRowModel)
        }
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    func showShareVC(petVariety: String = "",petImage: UIImage = UIImage()) {
        let activityVC = UIActivityViewController(activityItems: [petVariety,petImage],
                                                  applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func getLoveList() {
        if let petData = UserDefaults.standard.object(forKey: "pet") as? Data {
            if let loadedPets = try? JSONDecoder().decode([PetModel].self, from: petData) {
                self.lovePetList  = loadedPets
            }
        }
    }
    func setLoveList() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.lovePetList) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "pet")
        }
    }
    
    func gotoPetDetailVC(petModel:PetModel?) {
        
    }
    
}

