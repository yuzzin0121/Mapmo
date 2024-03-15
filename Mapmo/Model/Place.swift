//
//  Place.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation
import RealmSwift

struct PlaceModel: Decodable {
    let total: Int
    let start: Int
    let items: [PlaceItem]
}

struct PlaceItem: Decodable {
    let title: String
    let link: String
    let address: String
    let roadAddress: String
    let mapx: String
    let mapy: String
}

// Realm 모델
class Place: Object {
    @Persisted(primaryKey: true) var roadAddress: String
    @Persisted var mapx: Int
    @Persisted var mapy: Int
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var records: List<Record>
    
    convenience init(roadAddress: String, mapx: Int, mapy: Int, title: String, link: String) {
        self.init()
        self.roadAddress = roadAddress
        self.mapx = mapx
        self.mapy = mapy
        self.title = title
        self.link = link
    }
}
