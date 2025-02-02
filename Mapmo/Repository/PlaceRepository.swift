//
//  PlaceRepository.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import Foundation
import RealmSwift

final class PlaceRepository {
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
    
    // 등록된 장소 모두 불러오기d
    func fetchPlace() -> [Place] {
        print(realm.configuration.fileURL)
        let places = Array(realm.objects(Place.self).sorted(byKeyPath: "modifiedAt", ascending: false))
        return places
    }
    
    func getPlace(address: String) -> Place? {
        return realm.object(ofType: Place.self, forPrimaryKey: address)
    }
    
    func updateModifiedAt(address: String) {
        guard let place = getPlace(address: address) else { return }
        do {
            try realm.write {
                place.modifiedAt = Date()
            }
        } catch {
            print(error)
        }
    }
    
    func getVisiblePlaces(x1: Double, x2: Double, y1: Double, y2: Double) -> [Place] {
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
            $0.address == place.address
        })
        
        return !places.isEmpty
    }
}
