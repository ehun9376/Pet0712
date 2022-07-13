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
    }
    
    func setDefaultTableView() {
        self.adapter = .init(mTableView)
        mTableView.register(UINib(nibName: PetTableViewCellRowModel().cellReUseID(), bundle: nil), forCellReuseIdentifier: PetTableViewCellRowModel().cellReUseID())
    }
    
    func setupRow() {
        self.getLoveList()
        var rowModels: [CellRowModel] = []
        let sortList = self.petList.sorted { lPet, rPet in
            lPet.animalId ?? 0  > rPet.animalId ?? 0
        }
        for pet in sortList {
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
        if let petModel = petModel {
            let petDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PetViewController") as? PetViewController
            petDetailVC?.pet = petModel
            self.navigationController?.pushViewController(petDetailVC ?? .init(), animated: true)
        }
        
    }
    
}

