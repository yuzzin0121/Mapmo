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
    
    func updateRecord(_ record: Record, recordId: ObjectId, place: Place?) {
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
                if let place = place {
                    if let record = getRecord(recordId: record.id), let currentPlace = record.place.first {
                        if let index = currentPlace.records.firstIndex(where: { $0.id == record.id }) {
                            print("삭제할 인덱스 찾음")
                            currentPlace.records.remove(at: index)
                            if currentPlace.records.isEmpty {
                                placeRepository.deletePlace(placeName: currentPlace.roadAddress)
                            }
                            place.records.append(record)
                        }
                    }
                }
            }
        } catch {
            print(error)
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
}
