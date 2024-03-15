//
//  Record.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import Foundation
import RealmSwift

class Record: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var visitedAt: Date
    @Persisted var createdAt: Date
    @Persisted var modifiedAt: Date
    @Persisted var isFavorite: Bool
    @Persisted var categoryId: String
    
    @Persisted(originProperty: "records") var place: LinkingObjects<Place>
    
    convenience init(title: String, content: String? = nil, visitedAt: Date, createdAt: Date, modifiedAt: Date, isFavorite: Bool = false, categoryId: String) {
        self.init()
        self.title = title
        self.content = content
        self.visitedAt = visitedAt
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.isFavorite = isFavorite
        self.categoryId = categoryId
    }
}
