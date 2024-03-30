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
final class Place: Object {
    @Persisted(primaryKey: true) var address: String
    @Persisted var lat: Double
    @Persisted var lng: Double
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var records: List<Record>
    
    convenience init(address: String, lat: Double, lng: Double, title: String, link: String) {
        self.init()
        self.address = address
        self.lat = lat
        self.lng = lng
        self.title = title
        self.link = link
    }
}
