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
        }
    }
    
    private func changeToNMGLatLng(_ coordinate: CLLocationCoordinate2D) {
        outputCurrentLatLng.value = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    
}
