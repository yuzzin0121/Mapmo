//
//  DetailRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import Foundation

final class DetailRecordViewModel {
    var inputRecordItem: Observable<RecordItem?> = Observable(nil)
    var deleteRecordTrigger: Observable<Void?> = Observable(nil)
    let fileManagerClass = FileManagerClass()
    let recordRepository = RecordRepository()
    lazy var placeRepository = PlaceRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        deleteRecordTrigger.bind { value in
            if value == nil { return }
            self.deleteRecord()
        }
    }
    
    private func deleteRecord() {
        guard let recordItem = inputRecordItem.value else { return }
        print(recordItem.id.stringValue)
        fileManagerClass.removeImagesFromDocument(recordId: recordItem.id.stringValue)
    
        recordRepository.deleteRecord(recordItem.id)
        if recordItem.place.records.count == 0 {
            placeRepository.deletePlace(placeName: recordItem.place.roadAddress)
        }
    }
}
