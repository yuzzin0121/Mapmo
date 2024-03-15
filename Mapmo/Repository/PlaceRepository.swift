//
//  PlaceRepository.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import Foundation
import RealmSwift

class PlaceRepository {
    private let realm = try! Realm()
    
    // 카테고리 추가
    func createPlace(_ place: Place) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(place)
                print("Create place")
            }
        } catch {
            print("create Place error", error)
        }
    }
    
    // 등록된 장소 모두 불러오기
    func fetchPlace() -> [Place] {
        let places = Array(realm.objects(Place.self))
        return places
    }
    
    func isExistPlace(_ place: Place) -> Bool {
        let places: [Place] = Array(realm.objects(Place.self).where {
            $0.roadAddress == place.roadAddress
        })
        
        return !places.isEmpty
    }
}
