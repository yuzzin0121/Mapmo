//
//  MapViewModel.swift
//  Mapmo
//
//  Created by 조유진 on 3/11/24.
//

import Foundation
import CoreLocation
import NMapsMap

final class MapViewModel {
    var addRecordButtonTrigger: Observable<Void?> = Observable(nil)
    
    var inputCurrentLocation: Observable<CLLocationCoordinate2D?> = Observable(nil)
    var outputCurrentLatLng: Observable<NMGLatLng?> = Observable(nil)
    var inputVisibleRegion: Observable<NMGLatLngBounds?> = Observable(nil)
    var searchedPlaces: Observable<[Place]> = Observable([])
    var outputPlaceMarkerList: Observable<[NMFMarker]> = Observable([])
    var outputRecordList: Observable<[RecordItem]> = Observable([])
    
    let placeRepository = PlaceRepository()
    let categoryRepository = CategoryRepository()
    let fileManagerClass = FileManagerClass()
    
    init() {
        transform()
    }
    
    private func transform() {
        inputCurrentLocation.bind { coordinate in
            guard let coordinate = coordinate else { return }
            self.changeToNMGLatLng(coordinate)
        }
        inputVisibleRegion.bind { visibleRegion in
            guard let visibleRegion = visibleRegion else { return }
            self.getVisiblePlace(visibleRegion)
        }
        searchedPlaces.bind { places in
            self.setMarkers(places: places)
            self.setRecordList(places: places)
        }
    }
    
    private func setRecordList(places: [Place]) {
        
        var recordItems: [RecordItem] = []
        for place in places {
            let records = place.records
            for record in records {
                let id = record.id
                // id를 통해 등록된 이미지들, 카테고리 가져오기
                guard let images = fileManagerClass.loadImagesToDocument(recordId: id.stringValue, imageCount: record.imageCount),
                      let category = categoryRepository.getCategory(categoryName: record.categoryId),
                      let place = record.place.first else {
                    
                    print("뭐가 없는걸까..?")
                    return
                }
                
                let recordItem = RecordItem(id: id,
                                            memo: record.memo,
                                            images: images,
                                            category: category,
                                            place: place,
                                            isFavorite: record.isFavorite,
                                            visitedAt: record.visitedAt,
                                            createdAt: record.createdAt,
                                            modifiedAt: record.modifiedAt)
                recordItems.append(recordItem)
            }
        }
        outputRecordList.value = recordItems
    }
    
    private func setMarkers(places: [Place]) {
        var markers: [NMFMarker] = []
        for marker in outputPlaceMarkerList.value {
            marker.mapView = nil
        }
        for place in places {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: place.lat, lng: place.lng)
            
            guard let record = place.records.first, let category = categoryRepository.getCategory(categoryName: record.categoryId) else {
                break
                return
            }
            print()
            marker.iconImage = NMFOverlayImage(name: category.colorName)
            marker.width = 35
            marker.height = 35
            markers.append(marker)
        }
        outputPlaceMarkerList.value =  markers
    }
    
    private func getVisiblePlace(_ visibleRegion: NMGLatLngBounds) {
        let southWest = visibleRegion.southWest
        let northEast = visibleRegion.northEast
        let places = self.placeRepository.getVisiblePlaces(x1: southWest.lat,
                                                           x2: northEast.lat,
                                                           y1: southWest.lng,
                                                           y2: northEast.lng)
        self.searchedPlaces.value = places
    }
    
    private func changeToNMGLatLng(_ coordinate: CLLocationCoordinate2D) {
        outputCurrentLatLng.value = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    
}
