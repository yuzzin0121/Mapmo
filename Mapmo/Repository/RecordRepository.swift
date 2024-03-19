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
    
    func createRecord(_ record: Record, place: Place?) {
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
