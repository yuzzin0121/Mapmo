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
    var moveCameraPlaceTrigger: Observable<Void?> = Observable(nil)
    var inputCurrentLocation: Observable<CLLocationCoordinate2D?> = Observable(nil)
    var outputCurrentLatLng: Observable<NMGLatLng?> = Observable(nil)
    var inputVisibleRegion: Observable<NMGLatLngBounds?> = Observable(nil)
    var searchedPlaces: Observable<[Place]> = Observable([])
    var outputPlaceMarkerList: Observable<[NMFMarker]> = Observable([])
    var outputRecordList: Observable<[RecordItem]> = Observable([])
    var outputRecentPlaceLatLng: Observable<NMGLatLng?> = Observable(nil)
    
    private let placeRepository = PlaceRepository()
    private let categoryRepository = CategoryRepository()
    private let fileManagerClass = FileManagerClass()
    
    init() {
        transform()
    }
    
    deinit {
        print("Deinit" + String(describing: self))
    }
    
    private func transform() {
        inputCurrentLocation.bind { [weak self] coordinate in
            guard let coordinate = coordinate, let self = self else { return }
            self.changeToNMGLatLng(coordinate)
        }
        inputVisibleRegion.bind { [weak self] visibleRegion in
            guard let visibleRegion = visibleRegion, let self = self else { return }
            self.getVisiblePlace(visibleRegion)
        }
        searchedPlaces.bind { [weak self] places in
            guard let self = self else { return }
            self.setMarkers(places: places)
            self.setRecordList(places: places)
        }
        moveCameraPlaceTrigger.bind { [weak self] value in
            guard let value = value, let self = self else { return }
            self.fetchPlaces()
        }
    }
    
    private func fetchPlaces() {
        searchedPlaces.value = placeRepository.fetchPlace()
        if !searchedPlaces.value.isEmpty {
            guard let recentPlace = searchedPlaces.value.first else {
                return
            }
            outputRecentPlaceLatLng.value = NMGLatLng(lat: recentPlace.lat, lng: recentPlace.lng)
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
            marker.iconImage = NMFOverlayImage(name: "\(category.colorName)Image")
            marker.width = 35
            marker.height = 35
            markers.append(marker)
        }
        outputPlaceMarkerList.value =  markers
    }
    
    // 현 지도에 보이는 장소들 가져오기
    private func getVisiblePlace(_ visibleRegion: NMGLatLngBounds) {
        let southWest = visibleRegion.southWest
        let northEast = visibleRegion.northEast
        let places = placeRepository.getVisiblePlaces(x1: southWest.lat,
                                                           x2: northEast.lat,
                                                           y1: southWest.lng,
                                                           y2: northEast.lng)
        searchedPlaces.value = places
    }
    
    private func changeToNMGLatLng(_ coordinate: CLLocationCoordinate2D) {
        outputCurrentLatLng.value = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    
}
