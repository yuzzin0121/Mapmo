//
//  Place.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation

struct Place: Decodable {
    let total: Int
    let start: Int
    let items: [PlaceItem]
}

struct PlaceItem: Decodable {
    let title: String
    let link: String
    let address: String
    let mapx: String
    let mapy: String
}
