//
//  PetModel.swift
//  Pet
//
//  Created by Kai on 2022/7/11.
//

import Foundation
class PetModel: NSObject, Codable ,NSCoding{
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? PetModel else {
            return false
        }
        return self.albumFile == object.albumFile &&
        self.albumUpdate == object.albumUpdate &&
        self.animalVariety == object.animalVariety &&
        self.animalAge == object.animalAge &&
        self.animalAreaPkid == object.animalAreaPkid &&
        self.animalBacterin == object.animalBacterin &&
        self.animalBodytype == object.animalBodytype &&
        self.animalCaption == object.animalCaption &&
        self.animalCloseddate == object.animalCloseddate &&
        self.animalColour == object.animalColour &&
        self.animalCreatetime == object.animalCreatetime &&
        self.animalFoundplace == object.animalFoundplace &&
        self.animalId == object.animalId &&
        self.animalKind == object.animalKind &&
        self.animalOpendate == object.animalOpendate &&
        self.animalPlace == object.animalPlace &&
        self.animalRemark == object.animalRemark &&
        self.animalSex == object.animalSex &&
        self.animalShelterPkid == object.animalShelterPkid &&
        self.animalStatus == object.animalStatus &&
        self.animalSterilization == object.animalSterilization &&
        self.animalSubid == object.animalSubid &&
        self.animalTitle == object.animalTitle &&
        self.animalUpdate == object.animalUpdate &&
        self.cDate == object.cDate &&
        self.shelterAddress == object.shelterAddress &&
        self.shelterName == object.shelterName &&
        self.shelterTel == object.shelterTel
    }

    let albumFile : String
    let albumUpdate : String?
    let animalVariety : String?
    let animalAge : String?
    let animalAreaPkid : Int?
    let animalBacterin : String?
    let animalBodytype : String?
    let animalCaption : String?
    let animalCloseddate : String?
    let animalColour : String?
    let animalCreatetime : String?
    let animalFoundplace : String?
    let animalId : Int?
    let animalKind : String?
    let animalOpendate : String?
    let animalPlace : String?
    let animalRemark : String?
    let animalSex : String?
    let animalShelterPkid : Int?
    let animalStatus : String?
    let animalSterilization : String?
    let animalSubid : String?
    let animalTitle : String?
    let animalUpdate : String?
    let cDate : String?
    let shelterAddress : String?
    let shelterName : String?
    let shelterTel : String?
    
    func encode(with coder: NSCoder) {
        
//        let albumFile : String
        coder.encode(self.albumFile, forKey: "albumFile")
//        let albumUpdate : String?
        coder.encode(self.albumUpdate, forKey: "albumUpdate")
//        let animalVariety : String?
        coder.encode(self.animalVariety, forKey: "animalVariety")
//        let animalAge : String?
        coder.encode(self.animalAge, forKey: "animalAge")
//        let animalAreaPkid : Int?
        coder.encode(self.animalAreaPkid, forKey: "animalAreaPkid")
//        let animalBacterin : String?
        coder.encode(self.animalBacterin, forKey: "animalBacterin")
//        let animalBodytype : String?
        coder.encode(self.animalBodytype, forKey: "animalBodytype")
//        let animalCaption : String?
        coder.encode(self.animalCaption, forKey: "animalCaption")
//        let animalCloseddate : String?
        coder.encode(self.animalCloseddate, forKey: "animalCloseddate")
//        let animalColour : String?
        coder.encode(self.animalColour, forKey: "animalColour")
//        let animalCreatetime : String?
        coder.encode(self.animalCreatetime, forKey: "animalCreatetime")
//        let animalFoundplace : String?
        coder.encode(self.animalFoundplace, forKey: "animalFoundplace")
//        let animalId : Int?
        coder.encode(self.animalId, forKey: "animalId")
//        let animalKind : String?
        coder.encode(self.animalKind, forKey: "animalKind")
//        let animalOpendate : String?
        coder.encode(self.animalOpendate, forKey: "animalOpendate")
//        let animalPlace : String?
        coder.encode(self.animalPlace, forKey: "animalPlace")
//        let animalRemark : String?
        coder.encode(self.animalRemark, forKey: "animalRemark")
//        let animalSex : String?
        coder.encode(self.animalSex, forKey: "animalSex")
//        let animalShelterPkid : Int?
        coder.encode(self.animalShelterPkid, forKey: "animalShelterPkid")
//        let animalStatus : String?
        coder.encode(self.animalStatus, forKey: "animalStatus")
//        let animalSterilization : String?
        coder.encode(self.animalSterilization, forKey: "animalSterilization")
//        let animalSubid : String?
        coder.encode(self.animalSubid, forKey: "animalSubid")
//        let animalTitle : String?
        coder.encode(self.animalTitle, forKey: "animalTitle")
//        let animalUpdate : String?
        coder.encode(self.animalUpdate, forKey: "animalUpdate")
//        let cDate : String?
        coder.encode(self.cDate, forKey: "cDate")
//        let shelterAddress : String?
        coder.encode(self.shelterAddress, forKey: "shelterAddress")
//        let shelterName : String?
        coder.encode(self.shelterName, forKey: "shelterName")
//        let shelterTel : String?
        coder.encode(self.shelterTel, forKey: "shelterTel")

    }
    
    required init?(coder: NSCoder) {
//        let albumFile : String
        self.albumFile = coder.decodeObject(forKey: "albumFile") as? String ?? ""
//        let albumUpdate : String?
        self.albumUpdate = coder.decodeObject(forKey: "albumUpdate") as? String ?? ""
//        let animalVariety : String?
        self.animalVariety = coder.decodeObject(forKey: "animalVariety") as? String ?? ""
//        let animalAge : String?
        self.animalAge = coder.decodeObject(forKey: "animalAge") as? String ?? ""
//        let animalAreaPkid : Int?
        self.animalAreaPkid = coder.decodeObject(forKey: "animalAreaPkid") as? Int ?? 0
//        let animalBacterin : String?
        self.animalBacterin = coder.decodeObject(forKey: "animalBacterin") as? String ?? ""
//        let animalBodytype : String?
        self.animalBodytype = coder.decodeObject(forKey: "animalBodytype") as? String ?? ""
//        let animalCaption : String?
        self.animalCaption = coder.decodeObject(forKey: "animalCaption") as? String ?? ""
//        let animalCloseddate : String?
        self.animalCloseddate = coder.decodeObject(forKey: "animalCloseddate") as? String ?? ""
//        let animalColour : String?
        self.animalColour = coder.decodeObject(forKey: "animalColour") as? String ?? ""
//        let animalCreatetime : String?
        self.animalCreatetime = coder.decodeObject(forKey: "animalCreatetime") as? String ?? ""
//        let animalFoundplace : String?
        self.animalFoundplace = coder.decodeObject(forKey: "animalFoundplace") as? String ?? ""
//        let animalId : Int?
        self.animalId = coder.decodeObject(forKey: "animalId") as? Int ?? 0
//        let animalKind : String?
        self.animalKind = coder.decodeObject(forKey: "animalKind") as? String ?? ""
//        let animalOpendate : String?
        self.animalOpendate = coder.decodeObject(forKey: "animalOpendate") as? String ?? ""
//        let animalPlace : String?
        self.animalPlace = coder.decodeObject(forKey: "animalPlace") as? String ?? ""
//        let animalRemark : String?
        self.animalRemark = coder.decodeObject(forKey: "animalRemark") as? String ?? ""
//        let animalSex : String?
        self.animalSex = coder.decodeObject(forKey: "animalSex") as? String ?? ""
//        let animalShelterPkid : Int?
        self.animalShelterPkid = coder.decodeObject(forKey: "animalShelterPkid") as? Int ?? 0
//        let animalStatus : String?
        self.animalStatus = coder.decodeObject(forKey: "animalStatus") as? String ?? ""
//        let animalSterilization : String?
        self.animalSterilization = coder.decodeObject(forKey: "animalSterilization") as? String ?? ""
//        let animalSubid : String?
        self.animalSubid = coder.decodeObject(forKey: "animalSubid") as? String ?? ""
//        let animalTitle : String?
        self.animalTitle = coder.decodeObject(forKey: "animalTitle") as? String ?? ""
//        let animalUpdate : String?
        self.animalUpdate = coder.decodeObject(forKey: "animalUpdate") as? String ?? ""
//        let cDate : String?
        self.cDate = coder.decodeObject(forKey: "cDate") as? String ?? ""
//        let shelterAddress : String?
        self.shelterAddress = coder.decodeObject(forKey: "shelterAddress") as? String ?? ""
//        let shelterName : String?
        self.shelterName = coder.decodeObject(forKey: "shelterName") as? String ?? ""
//        let shelterTel : String?
        self.shelterTel = coder.decodeObject(forKey: "shelterTel") as? String ?? ""

    }
//    static func encodeData(widgetDataArray : [PetModel]) -> Data? {
//        do {
//            NSKeyedUnarchiver.setClass(PetModel.self, forClassName: "PetModel")
//            let data = try NSKeyedArchiver.archivedData(withRootObject: widgetDataArray as Array, requiringSecureCoding: false)
//            return data
//        } catch {
//            return nil
//        }
//        
//    }
//
//    static func deCodeData(unarchivedObject: Data) -> [PetModel]? {
//        do{
//            NSKeyedUnarchiver.setClass(PetModel.self, forClassName: "PetModel")
////            let array = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, SearchCode.self], from: unarchivedObject) as? [SearchCode]
//            if let any = ((try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedObject)) as Any??), let array = any as? [PetModel]? {
//                return array
//            } else {
//                return []
//            }
//        }
//    }
    


    enum CodingKeys: String, CodingKey {
        case albumFile = "album_file"
        case albumUpdate = "album_update"
        case animalVariety = "animal_Variety"
        case animalAge = "animal_age"
        case animalAreaPkid = "animal_area_pkid"
        case animalBacterin = "animal_bacterin"
        case animalBodytype = "animal_bodytype"
        case animalCaption = "animal_caption"
        case animalCloseddate = "animal_closeddate"
        case animalColour = "animal_colour"
        case animalCreatetime = "animal_createtime"
        case animalFoundplace = "animal_foundplace"
        case animalId = "animal_id"
        case animalKind = "animal_kind"
        case animalOpendate = "animal_opendate"
        case animalPlace = "animal_place"
        case animalRemark = "animal_remark"
        case animalSex = "animal_sex"
        case animalShelterPkid = "animal_shelter_pkid"
        case animalStatus = "animal_status"
        case animalSterilization = "animal_sterilization"
        case animalSubid = "animal_subid"
        case animalTitle = "animal_title"
        case animalUpdate = "animal_update"
        case cDate = "cDate"
        case shelterAddress = "shelter_address"
        case shelterName = "shelter_name"
        case shelterTel = "shelter_tel"
    }
}
struct TestModel: Decodable {
    let testTitle: String?
    
}
