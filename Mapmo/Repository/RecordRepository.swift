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
}
