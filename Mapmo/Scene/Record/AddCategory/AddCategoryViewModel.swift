//
//  AddCategoryViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation

class AddCategoryViewModel {
    var inputCategoryName: Observable<String?> = Observable(nil)
    var outputWarningMessage: Observable<String?> = Observable(nil)
    var isValidName: Observable<Bool> = Observable(false)
    
    var colorList: Observable<[CategoryColor]> = Observable([])
    var selectedColor: Observable<CategoryColor?> = Observable(nil)
    
    init() {
        transform()
    }
    
    deinit {
        print("AddCategoryViewModel Deinit")
    }
    
    private func transform() {
        colorList.value = CategoryColor.allCases
        inputCategoryName.bind { name in
            self.validateCategoryName(name: name)
        }
    }
    
    private func validateCategoryName(name: String?) {
        guard let name = name else { return }
        
        var pattern = "^.{2,14}$"
        if name.isEmpty || name.range(of: pattern, options: .regularExpression) == nil {
            outputWarningMessage.value = ValidationCategoryNameError.invalidateLength.message
            isValidName.value = false
            return
        }
        
        pattern = "^[^@#$%]*$"
        
        if name.range(of: pattern, options: .regularExpression) == nil {
            outputWarningMessage.value = ValidationCategoryNameError.isSpecialChars.message
            isValidName.value = false
            return
        }
        
        outputWarningMessage.value = ""
        isValidName.value = true
    }
}
