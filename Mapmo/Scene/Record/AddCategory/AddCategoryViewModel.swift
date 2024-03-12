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
    var isActive: Observable<Bool> = Observable(false)
    
    var addButtonClickTrigger: Observable<Void?> = Observable(nil)
    
    let categoryRepository = CategoryRepository()
    
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
        isValidName.bind { value in
            self.confirmActive(isValidName: value)
        }
        selectedColor.bind { value in
            self.confirmActive(isValidName: self.isValidName.value)
        }
        
        addButtonClickTrigger.bind { value in
            guard let value = value else { return }
            self.addCategory()
        }
    }
    
    // Realm에 카테고리 추가
    private func addCategory() {
        guard let categoryName = inputCategoryName.value else { return }
        guard let selectedColor = selectedColor.value else { return }
        
        let category = Category(name: categoryName, colorName: selectedColor.name)
        categoryRepository.createCategory(category)
    }
    
    
    private func confirmActive(isValidName: Bool) {
        if isValidName && self.selectedColor.value != nil {
            isActive.value = true
        } else {
            isActive.value = false
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
