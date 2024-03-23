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
        let places = Array(realm.objects(Place.self).sorted(byKeyPath: "roadAddress", ascending: true))
        return places
    }
    
    func getVisiblePlaces(x1: Double, x2: Double, y1: Double, y2: Double) -> [Place] {
        print("\(x1), \(y1)----\(x2), \(y2)")
        let predicate = NSPredicate(format: "lat >= %f && lat <= %f && lng >= %f && lng <= %f", x1, x2, y1, y2)
        let places = realm.objects(Place.self).filter(predicate)
        return Array(places)
    }
    
    func deletePlace(placeName: String) {
        if let place = realm.object(ofType: Place.self, forPrimaryKey: placeName) {
            do {
                try realm.write {
                    realm.delete(place)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func isExistPlace(_ place: Place) -> Bool {
        let places: [Place] = Array(realm.objects(Place.self).where {
            $0.roadAddress == place.roadAddress
        })
        
        return !places.isEmpty
    }
}
