//
//  MyRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/18/24.
//

import Foundation

class MyRecordViewModel {
    var inputSelectedDate: Observable<Date> = Observable(Date())
    var outputSelectedDateRecordList: Observable<[RecordItem]> = Observable([])
    
    let recordRepository = RecordRepository()
    let categoryRepository = CategoryRepository()
    let fileManagerClass = FileManagerClass()
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSelectedDate.bind { selectedDate in
            self.getSelectedDateRecords(selectedDate: selectedDate)
        }
    }
    
    func getNumberOfEventDate(date: Date) -> Int {
        return recordRepository.fetchRecordFromDate(date: date).count
    }
    
    private func getSelectedDateRecords(selectedDate: Date) {
//        outputSelectedDateRecordList.value = recordRepository.fetchRecordFromDate(date: selectedDate)
        let selectedDateRecordList = recordRepository.fetchRecordFromDate(date: selectedDate)
        var recordItems: [RecordItem] = []
        for record in selectedDateRecordList {
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
        outputSelectedDateRecordList.value = recordItems
        
    }
}
