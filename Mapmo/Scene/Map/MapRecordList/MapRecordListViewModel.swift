//
//  MapRecordListViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/21/24.
//

import Foundation

class MapRecordListViewModel {
    var inputRecordList: Observable<[RecordItem]> = Observable([])
    var toggleIsFavorite: Observable<Int?> = Observable(nil)
    
    let recordRepository = RecordRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        toggleIsFavorite.bind { index in
            guard let index = index else { return }
            self.toggleIsFavorite(index)
        }
    }
    
    private func toggleIsFavorite(_ index: Int) {
        let record = inputRecordList.value[index]
        recordRepository.updateFavorite(record.id)
    }
}
