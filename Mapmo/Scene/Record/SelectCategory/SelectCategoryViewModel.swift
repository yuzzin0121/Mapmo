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
    
    private let categoryRepository = CategoryRepository()
    
    init() {
        transform()
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    private func transform() {
        fetchCategoryTrigger.bind { [weak self] value in
            guard let value = value, let self = self else { return }
            self.categoryList.value = self.categoryRepository.fetchCategory()
        }
    }
}
