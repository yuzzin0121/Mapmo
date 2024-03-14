//
//  SearchPlaceViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation

class SearchPlaceViewModel {
    var inputSearchText: Observable<String?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        
    }
    
    private func callRequest(query: String, display: Int, sort: String) {
        NaverMapAPIManager.shared.fetchData(type: Place.self, api: .place(query: query, display: display, sort: sort)) { response, error in
            if error == nil {
                guard let response = response else { return }
                print(response)
                print(response.items)
            } else {
                guard let error = error else { return }
                
            }
        }
    }
    
    private func validate() {
        
    }
}
