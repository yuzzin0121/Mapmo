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
    
    let placeRepository = PlaceRepository()
    
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
    }
    
    private func getVisiblePlace(_ visibleRegion: NMGLatLngBounds) {
        let southWest = visibleRegion.southWest
        let northEast = visibleRegion.northEast
        let places = self.placeRepository.getVisiblePlaces(x1: southWest.lat,
                                                           x2: northEast.lat,
                                                           y1: southWest.lng,
                                                           y2: northEast.lng)
        self.searchedPlaces.value = places
        print(places)
        print(self.placeRepository.fetchPlace())
    }
    
    private func changeToNMGLatLng(_ coordinate: CLLocationCoordinate2D) {
        outputCurrentLatLng.value = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    
}
