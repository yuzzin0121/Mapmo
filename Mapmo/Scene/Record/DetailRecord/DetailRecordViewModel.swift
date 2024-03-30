//
//  DetailRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/19/24.
//

import Foundation
import RealmSwift

final class DetailRecordViewModel {
    var inputRecordItem: Observable<RecordItem?> = Observable(nil)
    var deleteRecordTrigger: Observable<Void?> = Observable(nil)
    var inputRecordId: Observable<ObjectId?> = Observable(nil)
    
    private let fileManagerClass = FileManagerClass()
    private let recordRepository = RecordRepository()
    private lazy var placeRepository = PlaceRepository()
    private lazy var categoryRepository = CategoryRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        deleteRecordTrigger.bind { value in
            if value == nil { return }
            self.deleteRecord()
        }
        
        inputRecordId.bind { id in
            guard let id = id else { return }
            self.refreshRecordItem(id: id)
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
    
    private func refreshRecordItem(id: ObjectId) {
        guard let record = recordRepository.getRecord(recordId: id) else { return }
        
        // id를 통해 등록된 이미지들, 카테고리 가져오기
        guard let images = fileManagerClass.loadImagesToDocument(recordId: id.stringValue, imageCount: record.imageCount),
              let category = categoryRepository.getCategory(categoryName: record.categoryId),
              let place = record.place.first else {
            
            print("뭐가 없는걸까..?")
            return
        }
        
        inputRecordItem.value = RecordItem(id: id,
                                    memo: record.memo,
                                    images: images,
                                    category: category,
                                    place: place,
                                    isFavorite: record.isFavorite,
                                    visitedAt: record.visitedAt,
                                    createdAt: record.createdAt,
                                    modifiedAt: record.modifiedAt)
    }
}
