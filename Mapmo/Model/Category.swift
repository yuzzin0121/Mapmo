//
//  CategoryRealmModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var colorName: String
    @Persisted var recordCount: Int
    
    convenience init(name: String, colorName: String, recordCount: Int = 0) {
        self.init()
        self.name = name
        self.colorName = colorName
        self.recordCount = recordCount
    }
}
