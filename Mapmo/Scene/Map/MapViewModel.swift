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
    var outputPlaceMarkerList: Observable<[PlaceMarker]> = Observable([])
    var outputPlaceMarkers: Observable<[NMFMarker]> = Observable([])
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
            guard let value, let self = self else { return }
            self.fetchPlaces()
        }
        outputPlaceMarkerList.bind { [weak self] markers in
            guard let self = self else { return }
            self.setMarkers(markers: markers)
        }
    }
    
    private func setMarkers(markers: [PlaceMarker]) {
        lazy var touchHandler = { (overlay: NMFOverlay) -> Bool in
            let userInfo = overlay.userInfo
            let data = userInfo["data"] as! PlaceMarker
            return true
        }
        
        for marker in outputPlaceMarkers.value {
            marker.mapView = nil
        }
        outputPlaceMarkers.value.removeAll()
        
        var markers: [NMFMarker] = []
        
        for placeMarker in outputPlaceMarkerList.value {
            let marker = NMFMarker()
            marker.width = 64
            marker.height = 82
            marker.position = placeMarker.latLng
            marker.touchHandler = touchHandler
            marker.userInfo = [ "data" : placeMarker ]
            
            let customView = PlaceMarkerView(frame: CGRect(x: 0, y: 0, width: 64, height: 82))
            let image = customView.configureView(data: placeMarker)
            marker.iconImage = NMFOverlayImage(image: image)
            marker.iconPerspectiveEnabled = true
            markers.append(marker)
        }
        
        outputPlaceMarkers.value = markers
        
    }
    
    private func fetchPlaces() {
        searchedPlaces.value = placeRepository.fetchPlace()
        if !searchedPlaces.value.isEmpty {
            guard let recentPlace = searchedPlaces.value.first else {
                outputRecentPlaceLatLng.value = NMGLatLng(lat: DefaultLatLng.defaultLat.rawValue, lng: DefaultLatLng.defaultLng.rawValue)
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
        var placeMarkers: [PlaceMarker] = []
        for marker in outputPlaceMarkerList.value {
//            marker.hidePlaceWindow()
//            marker.mapView = nil
        }
        for place in places {
            guard let record = place.records.first, let category = categoryRepository.getCategory(categoryName: record.categoryId), let image = fileManagerClass.loadFirstImageToDocument(recordId: record.id.stringValue) else {
                return
            }
            
            let position = NMGLatLng(lat: place.lat, lng: place.lng)
            let placeMarker = PlaceMarker(address: place.address, latLng: position, recordImage: image, categoryColorName: category.colorName)
            
            placeMarkers.append(placeMarker)
        }
        outputPlaceMarkerList.value =  placeMarkers
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
