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
    
    var petList = [PetModel]()
    
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
        var rowModels: [CellRowModel] = []
        for pet in self.petList {
            rowModels.append(PetTableViewCellRowModel(lableTitle: pet.animalVariety,
                                                      imageURLStr: pet.albumFile,
                                                      petModel: pet,
                                                      cellAction: { rowModel in
                guard  let rowModel =  rowModel as? PetTableViewCellRowModel else { return }
                self.gotoPetDetailVC(petModel: rowModel.petModel)
            }))
        }
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? PetViewController{
//            destination.pet = petList[mTableView.indexPathForSelectedRow!.row]
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: self)
//    }
    
    func gotoPetDetailVC(petModel:PetModel?) {
        if let petModel = petModel {
            let petDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PetViewController") as? PetViewController
            petDetailVC?.pet = petModel
            self.navigationController?.pushViewController(petDetailVC ?? .init(), animated: true)
        }
        
    }
    
}

//
//extension PetTableViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return petList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath)
//        as! PetTableViewCell
//
//        let pet = petList[indexPath.row]
//        cell.myLabel.text = pet.animalKind
//        cell.myImageView.sd_setImage(with: URL(string: pet.albumFile),
//        placeholderImage:UIImage(named:"LoadingImage"), options:[], completed: nil)
//
//
//        return cell
//    }
//
//
//}
//
//func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 100
//}



