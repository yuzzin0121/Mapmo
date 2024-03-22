//
//  RecordRepository.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import Foundation
import RealmSwift

class RecordRepository {
    private let realm = try! Realm()
    private let placeRepository = PlaceRepository()
    
    func createRecord(_ record: Record, place: Place?) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                if let place {
                    place.records.append(record)
                    print("Append Record To Place")
                }
                realm.add(record)
                print("Record Create")
            }
        } catch {
            print(error)
        }
    }
    
    func fetchRecordFromDate(date: Date) -> [Record] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "visitedAt >= %@ && visitedAt < %@", start as NSDate, end as NSDate)
        let list = realm.objects(Record.self).filter(predicate)
        
        return Array(list)
    }
    
    func getRecord(recordId: ObjectId) -> Record? {
        return realm.object(ofType: Record.self, forPrimaryKey: recordId)
    }
    
    func updateRecord(_ record: Record, recordId: ObjectId, place: Place) {
        print(realm.configuration.fileURL)
        // U
        do {
            try realm.write {
                realm.create(Record.self,
                             value: [
                                "id": recordId,
                                "memo": record.memo,
                                "imageCount": record.imageCount,
                                "visitedAt": record.visitedAt,
                                "modifiedAt": record.modifiedAt,
                                "categoryId": record.categoryId],
                             update: .modified)
            }
        } catch {
            print(error, "업데이트 실패")
        }
                
        do {
            if let record = getRecord(recordId: recordId) {
                print("record 있음")
                guard let currentPlace = record.place.first else { return }
                if currentPlace.roadAddress == place.roadAddress {
                    print("같은 장소임")
                    return
                } else {
                    try realm.write {
                        if removePlace(record: record, currentPlace: currentPlace) {
                            place.records.append(record)
                        } else {
                            print("제거 실패")
                        }
                    }
                }
            }
            
        } catch {
            print(error, "장소 업데이트 실패")
        }
    }
    
    private func removePlace(record: Record, currentPlace: Place) -> Bool {
        if let index = currentPlace.records.firstIndex(where: { $0.id == record.id}) {
            print("삭제할 인덱스 찾음")
            currentPlace.records.remove(at: index)
            if currentPlace.records.isEmpty {
                if let place = realm.object(ofType: Place.self, forPrimaryKey: currentPlace.roadAddress) {
                    print("처음 장소 삭제")
                    realm.delete(place)
                }
            }
            return true
        } else {
            return false
        }
    }
    
    func deleteRecord(_ recordId: ObjectId) {
        if let record = realm.object(ofType: Record.self, forPrimaryKey: recordId) {
            do {
                try realm.write {
                    realm.delete(record)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func updateFavorite(_ recordId: ObjectId) {
        guard let record = getRecord(recordId: recordId) else { return }
        do {
            try realm.write {
                record.isFavorite.toggle()
            }
        } catch {
            print(error)
        }
    }
}
