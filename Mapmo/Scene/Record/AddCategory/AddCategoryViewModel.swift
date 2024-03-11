//
//  AddCategoryViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation

class AddCategoryViewModel {
    var colorList: Observable<[CategoryColor]> = Observable([])
    var selectedColor: Observable<CategoryColor?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        colorList.value = CategoryColor.allCases
    }
}
