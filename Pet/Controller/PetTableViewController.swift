//
//  PetTableViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit

import UIKit
import SDWebImage
class PetTableViewController: UIViewController {

    @IBOutlet weak  var mTableView: UITableView!
    
    var adapter: TableViewAdapter?
    
    var petList: [PetModel] = []
    
    var lovePetList: [PetModel] = []
    
    var petType: PetType = .dog

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultTableView()
        NetworkService.downloadJson(type: petType) { result in
            switch result {
            case .success(let data):
                self.petList = data
                self.setupRow()
            case .failure(let error):
                print(error)
            }
        }
        if let petData = UserDefaults.standard.object(forKey: "pet") as? Data {
            if let loadedPets = try? JSONDecoder().decode([PetModel].self, from: petData) {
                self.lovePetList  = loadedPets
            }
        }


    }
    
    func setDefaultTableView() {
        self.adapter = .init(mTableView)
        mTableView.register(UINib(nibName: PetTableViewCellRowModel().cellReUseID(), bundle: nil), forCellReuseIdentifier: PetTableViewCellRowModel().cellReUseID())
    }
    
    func setupRow() {
        var rowModels: [CellRowModel] = []
        for pet in self.petList {
            if self.lovePetList.contains(pet){
                print("LOVeeeee")
            }
            rowModels.append(PetTableViewCellRowModel(lableTitle: pet.animalVariety,
                                                      imageURLStr: pet.albumFile,
                                                      petModel: pet,
                                                      cellAction: { rowModel in
                guard  let rowModel =  rowModel as? PetTableViewCellRowModel else { return }
                self.gotoPetDetailVC(petModel: rowModel.petModel)
                if let petModel = rowModel.petModel{
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode([petModel]) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "pet")
                    }
                }
            }))
        }
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    func gotoPetDetailVC(petModel:PetModel?) {
        if let petModel = petModel {
            let petDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PetViewController") as? PetViewController
            petDetailVC?.pet = petModel
            self.navigationController?.pushViewController(petDetailVC ?? .init(), animated: true)
        }
        
    }
    
}

