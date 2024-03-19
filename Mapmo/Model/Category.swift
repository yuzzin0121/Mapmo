//
//  CategoryRealmModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var colorName: String
    
    convenience init(name: String, colorName: String) {
        self.init()
        self.name = name
        self.colorName = colorName
    }
}
