//
//  MyRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/18/24.
//

import Foundation

class MyRecordViewModel {
    var inputSelectedDate: Observable<Date> = Observable(Date())
    var outputSelectedDateRecordList: Observable<[Record]> = Observable([])
    
    let recordRepository = RecordRepository()
    
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
        outputSelectedDateRecordList.value = recordRepository.fetchRecordFromDate(date: selectedDate)
    }
}
