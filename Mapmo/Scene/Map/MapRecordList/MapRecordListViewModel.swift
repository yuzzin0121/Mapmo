//
//  MapRecordListViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/21/24.
//

import Foundation

final class MapRecordListViewModel {
    var inputRecordList: Observable<[RecordItem]> = Observable([])
    var toggleIsFavorite: Observable<Int?> = Observable(nil)
    var outputRecordList: Observable<[RecordItem]> = Observable([])
    
    private let recordRepository = RecordRepository()
    
    init() {
        transform()
    }
    
    deinit {
        print(String(describing: self))
    }
    
    private func transform() {
        toggleIsFavorite.bind { [weak self] index in
            guard let index = index, let self = self else { return }
            self.toggleIsFavorite(index)
        }
    }
    
    private func toggleIsFavorite(_ index: Int) {
        let record = inputRecordList.value[index]
        inputRecordList.value[index].isFavorite.toggle()
        recordRepository.updateFavorite(record.id)
    }
}
