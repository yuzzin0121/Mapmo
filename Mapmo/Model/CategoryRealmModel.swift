//
//  CategoryRealmModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation
import RealmSwift

class CategoryRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var colorName: String
    
    convenience init(name: String, colorName: String) {
        self.init()
        self.name = name
        self.colorName = colorName
    }
}
