//
//  PetTableViewCell.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import UIKit

class PetTableViewCellRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        return "PetTableViewCell"
    }
    
    var labelTitle: String? = ""
    
    var imageURLStr: String? = ""
    
    var petModel: PetModel? = nil
    
    init(
        lableTitle: String? = "",
        imageURLStr: String? = "",
        petModel: PetModel? = nil,
        cellAction: ((CellRowModel)->())? = nil
    ) {
        super.init()
        self.labelTitle = lableTitle
        self.imageURLStr = imageURLStr
        self.petModel = petModel
        self.cellDidSelect = cellAction
    }
}

class PetTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PetTableViewCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? PetTableViewCellRowModel else { return }
        self.myLabel.text = rowModel.labelTitle
        if let urlStr = rowModel.imageURLStr  {
            DispatchQueue.main.async {
                self.myImageView.sd_setImage(with: URL(string: urlStr),
                                             placeholderImage:UIImage(named:"LoadingImage"),
                                             options:[.allowInvalidSSLCertificates],
                                             completed:{(image, error, cacheTRype, url)in
                    print(error?.localizedDescription ?? "")
                })
            }
        }

    }
}
