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
    
}
