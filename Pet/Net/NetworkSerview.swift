//
//  NetworkSerview.swift
//  PetAdoptionExercise
//
//  Created by wyn on 2022/7/10.
//

import Foundation
// 類別
enum PetType {
    case dog
    case cat
}
// 網路層
class NetworkService {
    static func downloadJson(type: PetType, completed: @escaping (Result<[PetModel], Error>)->()) {
        let _type: String = type == .dog ? "%E7%8B%97" : "%E8%B2%93"
        //type怎麼直接可以讀到
        let url = URL(string: "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&$top=20&$skip=0&animal_kind=" + _type)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil,let data = data else {
                print("DownloadWrong")
                return
            }
            do{
                let pets = try JSONDecoder().decode([PetModel].self, from: data)
                DispatchQueue.main.async {
                    completed(.success(pets))
                }
            } catch {
                print("JsonDecoderWrong")
            }
        }.resume()
    }
}

