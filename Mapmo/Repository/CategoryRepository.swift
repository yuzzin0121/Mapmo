//
//  CategoryRepository.swift
//  Mapmo
//
//  Created by 조유진 on 3/12/24.
//

import Foundation
import RealmSwift

class CategoryRepository {
    private let realm = try! Realm()
    
    // 카테고리 추가
    func createCategory(_ category: Category) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("create category error", error)
        }
    }
    
    func createCategoryList(_ categoryList: [Category]) {
        do {
            try realm.write {
                realm.add(categoryList)
            }
        } catch {
            print("create Place error", error)
        }
    }
    
    func fetchCategory() -> [Category] {
        let categories = Array(realm.objects(Category.self))
        return categories
    }
    
    func getCategory(categoryName: String) -> Category? {
        let categories = Array(realm.objects(Category.self).where {
            $0.name == categoryName
        })
        return categories.first
    }
    
}
