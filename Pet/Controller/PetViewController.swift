//
//  PetViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit
import SDWebImage
class PetViewController: UIViewController {

    @IBOutlet weak var petImg: UIImageView!
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var kindLbl: UILabel!
    @IBOutlet weak var sexLbl: UILabel!
    @IBOutlet weak var colourLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    
    var pet : PetModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idLbl.text = pet?.animalId?.description
        kindLbl.text = pet?.animalKind
        sexLbl.text = pet?.animalSex
        colourLbl.text = pet?.animalColour
        placeLbl.text = pet?.shelterName
        if let petData = pet {
            petImg.sd_setImage(with: URL(string:petData.albumFile), completed: nil)
        }
        

    }
    
    
    
}
