//
//  RecordRepository.swift
//  Mapmo
//
//  Created by 조유진 on 3/15/24.
//

import Foundation
import RealmSwift

final class RecordRepository {
    private let realm = try! Realm()
    private let placeRepository = PlaceRepository()
    
    func createRecord(_ record: Record, place: Place?) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                if let place {
                    place.records.append(record)
                    place.modifiedAt = Date()
                    print("Append Record To Place")
                }
                realm.add(record)
                print("Record Create")
            }
        } catch {
            print(error)
        }
    }
    
    deinit {
        print("Deinit RecordRepository")
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
    
    func fetchFavoriteRecords() -> [Record] {
        let records = realm.objects(Record.self).where {
            $0.isFavorite == true
        }.sorted(byKeyPath: "modifiedAt", ascending: true)
        return Array(records)
    }
    
    // 기록 수정 - 장소 수정할 경우 기존의 장소 제거 후(0개일 경우 삭제) 새로운 장소에 append
    func updateRecord(_ record: Record, recordId: ObjectId, place: Place) {
        // U
        realm.writeAsync {
            self.modifyRecord(record, recordId: recordId)
            
            if let record = self.getRecord(recordId: recordId) {
                guard let currentPlace = record.place.first else { return }
                if currentPlace.address == place.address {  // 현재 주소와 변경하려는 주소가 같을 경우
                    return
                } else {    // 주소 수정
                    if self.removePlace(record: record, currentPlace: currentPlace) {   // 현재 주소에서 record 삭제
                        place.records.append(record)    // 변경하려는 주소에 record 추가
                        place.modifiedAt = Date()       // 수정된 시간 업데이트
                    } else {
                        print("제거 실패")
                    }
                }
            }
        } onComplete: { error in
            guard let error = error else { return }
            print("update Record Error")
        }
    }
    
    private func modifyRecord(_ record: Record, recordId: ObjectId) {
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
    

    private func removePlace(record: Record, currentPlace: Place) -> Bool {
        if let index = currentPlace.records.firstIndex(where: { $0.id == record.id}) {
            print("삭제할 인덱스 찾음")
            currentPlace.records.remove(at: index)
            if currentPlace.records.isEmpty {
                if let place = realm.object(ofType: Place.self, forPrimaryKey: currentPlace.address) {
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
