//
//  SearchPlaceViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation

class SearchPlaceViewModel {
    var inputSearchText: Observable<String?> = Observable(nil)
    var searchButtonClickTrigger: Observable<Void?> = Observable(nil)
    var outputPlaceItemList: Observable<[PlaceItem]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        searchButtonClickTrigger.bind { value in
            guard let value = value else { return }
            self.validate(text: self.inputSearchText.value)
        }
    }
    
    private func callRequest(query: String, display: Int, sort: String) {
        NaverMapAPIManager.shared.fetchData(type: Place.self, api: .place(query: query, display: display, sort: sort)) { response, error in
            if error == nil {
                guard let response = response else { return }
                print(response)
                print(response.items)
                self.outputPlaceItemList.value = response.items
            } else {
                guard let error = error else { return }
                
            }
        }
    }
    
    private func validate(text: String?) {
        guard let text = text else { return }
        
        if text.isEmpty {
            return
        } else {
            callRequest(query: text, display: 1, sort: "random")
        }
    }
}
