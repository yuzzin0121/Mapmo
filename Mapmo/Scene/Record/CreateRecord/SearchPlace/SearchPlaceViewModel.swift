//
//  SearchPlaceViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/14/24.
//

import Foundation
import Network

final class SearchPlaceViewModel {
    var inputSearchText: Observable<String?> = Observable(nil)
    var searchButtonClickTrigger: Observable<Void?> = Observable(nil)
    var outputPlaceItemList: Observable<[PlaceItem]> = Observable([])
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var outputNetworkConnect: Observable<Void?> = Observable(nil)
    
    private let monitor = NWPathMonitor()
    
    init() {
        transform()
    }
    
    deinit {
        monitor.cancel()
        print("Deinit" + String(describing: self))
    }
    
    private func transform() {
        searchButtonClickTrigger.bind { [weak self] value in
            guard let self = self else { return }
            if value == nil { return }
            self.validate(text: self.inputSearchText.value)
        }
        
        inputViewDidLoadTrigger.bind { [weak self] value in
            guard let self = self else { return }
            if value == nil { return }
            self.handleNetwork()
        }
    }
    
    private func handleNetwork() {
        print(#function)
        monitor.start(queue: .global())
    }
    
    // 장소 검색
    private func callRequest(query: String, display: Int, sort: String) {
        if monitor.currentPath.status == .satisfied {
            
            print("satisfied")
            NaverMapAPIManager.shared.fetchData(type: PlaceModel.self, api: .place(query: query, display: display, sort: sort)) { [weak self] response, error in
                guard let self = self else { return }
                if error == nil {
                    guard let response = response else { return }
                    self.outputPlaceItemList.value = response.items
                } else {
                    guard let error = error else { return }
                    
                }
            }
            
        } else {
            print("Not satisfied")
            outputNetworkConnect.value = ()
        }
    }
    
    private func validate(text: String?) {
        guard let text = text else { return }
        let trimmedText = text.trimmingCharacters(in: [" "])
        
        if trimmedText.isEmpty {
            return
        } else {
            callRequest(query: trimmedText, display: 30, sort: "random")
        }
    }
}
