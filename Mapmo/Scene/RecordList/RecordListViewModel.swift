//
//  RecordListViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/23/24.
//

import Foundation

final class RecordListViewModel {
    var outputRecordItemList: Observable<[RecordItem]> = Observable([])
    var fetchFavoriteRecordsTrigger: Observable<Void?> = Observable(nil)
    var toggleIsFavorite: Observable<Int?> = Observable(nil)
    
    
    private let fileManagerClass = FileManagerClass()
    private let recordRepository = RecordRepository()
    private let categoryRepository = CategoryRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        fetchFavoriteRecordsTrigger.bind { value in
            if value == nil { return }
            self.fetchFavoriteRecordItem()
        }
        toggleIsFavorite.bind { index in
            guard let index = index else { return }
            self.toggleIsFavorite(index)
        }
    }
    
    private func toggleIsFavorite(_ index: Int) {
        let record = outputRecordItemList.value[index]
        recordRepository.updateFavorite(record.id)
    }
    
    private func fetchFavoriteRecordItem() {
        var recordItems: [RecordItem] = []
        let favoriteRecordList = recordRepository.fetchFavoriteRecords()
        for record in favoriteRecordList {
            let id = record.id
            // id를 통해 등록된 이미지들, 카테고리 가져오기
            guard let images = fileManagerClass.loadImagesToDocument(recordId: id.stringValue, imageCount: record.imageCount),
                  let category = categoryRepository.getCategory(categoryName: record.categoryId),
                  let place = record.place.first else {
                
                print("뭐가 없는걸까..?")
                return
            }
            
            let recordItem = RecordItem(id: id,
                                        memo: record.memo,
                                        images: images,
                                        category: category,
                                        place: place,
                                        isFavorite: record.isFavorite,
                                        visitedAt: record.visitedAt,
                                        createdAt: record.createdAt,
                                        modifiedAt: record.modifiedAt)
            recordItems.append(recordItem)
        }
        print(recordItems)
        outputRecordItemList.value = recordItems
        
    }
}
