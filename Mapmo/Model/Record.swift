//
//  Record.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import UIKit
import RealmSwift

final class Record: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var memo: String
    @Persisted var imageCount: Int
    @Persisted var visitedAt: Date
    @Persisted var createdAt: Date
    @Persisted var modifiedAt: Date
    @Persisted var isFavorite: Bool
    @Persisted var categoryId: String
    
    @Persisted(originProperty: "records") var place: LinkingObjects<Place>
    
    convenience init(memo: String, imageCount: Int, visitedAt: Date, createdAt: Date, modifiedAt: Date, isFavorite: Bool = false, categoryId: String) {
        self.init()
        self.memo = memo
        self.imageCount = imageCount
        self.visitedAt = visitedAt
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.isFavorite = isFavorite
        self.categoryId = categoryId
    }
}

struct RecordItem {
    let id: ObjectId
    var memo: String
    var images: [UIImage]
    var category: Category
    var place: Place
    var isFavorite: Bool
    var visitedAt: Date
    var createdAt: Date
    var modifiedAt: Date
}
