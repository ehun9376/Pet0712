//
//  NetworkSerview.swift
//  PetAdoptionExercise
//
//  Created by wyn on 2022/7/10.
//

import Foundation
// 網路層
class NetworkService {
    static func downloadJson(completed: ((Result<[PetModel], Error>) -> ())? = nil) {
        let url = URL(string: "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&$top=20&$skip=0" )
        URLSession.shared.dataTask(with: url!) { data, response, error in

            if let error = error {
                completed?(.failure(error))
            }
            guard let data = data else { return }
            do{
                let pets = try JSONDecoder().decode([PetModel].self, from: data)
                completed?(.success(pets))
                
            } catch {
                print("JsonDecoderWrong")
            }
        }.resume()
    }
}

