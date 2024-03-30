//
//  SelectCategoryViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import Foundation

final class SelectCategoryViewModel {
    var categoryList: Observable<[Category]> = Observable([])
    var fetchCategoryTrigger: Observable<Void?> = Observable(nil)
    var inputSelectedCategory: Observable<Category?> = Observable(nil)
    
    let categoryRepository = CategoryRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        fetchCategoryTrigger.bind { value in
            guard let value = value else { return }
            self.categoryList.value = self.categoryRepository.fetchCategory()
        }
    }
}
