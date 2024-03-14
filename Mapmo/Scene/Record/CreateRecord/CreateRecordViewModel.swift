//
//  CreateRecordViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import UIKit

class CreateRecordViewModel {
    var inputSelectedCategory: Observable<Category?> = Observable(nil)
    var inputRecordSectionList: Observable<[InputRecordSection]> = Observable(InputRecordSection.allCases)
    
    var inputSelectedImageList: Observable<[UIImage]> = Observable([])
    var inputPlaceItem: Observable<PlaceItem?> = Observable(nil)
    var inputVisitDate: Observable<Date?> = Observable(nil)
    var inputTitleText: Observable<String?> = Observable(nil)
    var inputContentText: Observable<String?> = Observable(nil)
    
    let contentTextViewPlaceholder = "내용 입력"
    
    init() {
        transform()
    }
    
    private func transform() {
        inputPlaceItem.bind { placeItem in
            guard let placeItem = placeItem else { return }
            print(placeItem)
        }
    }
    
    private func checkData() {
        if inputSelectedCategory.value != nil && inputSelectedImageList.value != nil
            && inputPlaceItem.value != nil {
            
        }
    }
    
}
