//
//  ModelManager.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/12.
//

import Foundation

class ModelManager {
    static func encodeData<modelType: NSCoding>(dataArray : [modelType]) -> Data? {
        do {
            NSKeyedUnarchiver.setClass(modelType.self, forClassName: "\(modelType.self)")
            let data = try NSKeyedArchiver.archivedData(withRootObject: dataArray as Array, requiringSecureCoding: false)
            return data
        } catch {
            return nil
        }
        
    }

    static func deCodeData<modelType: NSCoding>(type: modelType.Type,unarchivedObject: Data) -> [modelType]? {
        do{
            NSKeyedUnarchiver.setClass(modelType.self, forClassName: "\(modelType.self)")
            if let any = ((try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedObject)) as Any??), let array = any as? [modelType]? {
                return array
            } else {
                return []
            }
        }
    }
}
