//
//  CreateRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation

class CreateRecordViewModel {
    var inputSelectedCategory: Observable<Category?> = Observable(nil)
    var inputRecordSectionList: Observable<[InputRecordSection]> = Observable(InputRecordSection.allCases)
    
    init() {
        transform()
    }
    
    private func transform() {
        
    }
}
