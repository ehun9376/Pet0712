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
    
    var isLove: Bool = false
    
    var petModel: PetModel? = nil
    
    var shareButtonAction: ((String,UIImage)->())? = nil
    
    var loveButtonAction: ((PetModel)->())? = nil
    
    init(
        lableTitle: String? = "",
        imageURLStr: String? = "",
        isLove: Bool = false,
        petModel: PetModel? = nil,
        shareButtonAction: ((String,UIImage)->())? = nil,
        loveButtonAction: ((PetModel)->())? = nil,
        cellAction: ((CellRowModel)->())? = nil
    ) {
        super.init()
        self.labelTitle = lableTitle
        self.imageURLStr = imageURLStr
        self.isLove = isLove
        self.petModel = petModel
        self.shareButtonAction = shareButtonAction
        self.loveButtonAction = loveButtonAction
        self.cellDidSelect = cellAction
    }
}

class PetTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    var rowModel: PetTableViewCellRowModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        loveButton.addTarget(self, action: #selector(loveButtonAction), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
    }
    
    @objc func loveButtonAction() {
        if let rowModel = rowModel, let buttonAction = rowModel.loveButtonAction,let petModel = rowModel.petModel {
            buttonAction(petModel)
        }
    }
    @objc func shareButtonAction() {
        if let rowModel = rowModel, let buttonAction = rowModel.shareButtonAction {
            buttonAction(self.rowModel?.labelTitle ?? "", self.myImageView.image ?? UIImage())
        }
    }
}

extension PetTableViewCell: CellViewBase {
    func setupCellView(rowModel: CellRowModel) {
        guard let rowModel = rowModel as? PetTableViewCellRowModel else { return }
        self.myLabel.text = rowModel.labelTitle
        self.rowModel = rowModel
        self.loveButton.setTitle(rowModel.isLove ? "愛" : "不", for: .normal)
        self.shareButton.setTitle("分享", for: .normal)
        if let urlStr = rowModel.imageURLStr  {
            self.myImageView.sd_setImage(with: URL(string: urlStr),
                                         placeholderImage:UIImage(named:"LoadingImage"),
                                         options:[.allowInvalidSSLCertificates],
                                         completed:{(image, error, cacheTRype, url)in
                print(error?.localizedDescription ?? "")
            })
        }

    }
}
