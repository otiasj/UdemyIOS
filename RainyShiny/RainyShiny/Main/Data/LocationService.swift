//
//  LocationService.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/6/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var observer: AnyObserver<(latitude: Double, longitude: Double)>?
    
    func loadCurrentLocation() -> Observable<(latitude: Double, longitude: Double)> {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        return Observable<(latitude: Double, longitude: Double)>.create { observer in
            self.observer = observer
            if (self.hasLocationAuthorization()) {
                if let location = self.getCurrentLocation() {
                    print("location\(location)")
                    observer.onNext(location)
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(domain: "Location unknown", code: 404))
                }
            } else {
                self.observer = observer
                self.requestAuthorization()
            }
            return Disposables.create()
        }
    }
    
    func hasLocationAuthorization() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (self.hasLocationAuthorization()) {
            if let location = self.getCurrentLocation() {
                print("location\(location)")
                self.observer?.onNext(location)
                self.observer?.onCompleted()
            } else {
                self.observer?.onError(NSError(domain: "Location unknown", code: 404))
            }
        }
    }
    
    private func getCurrentLocation() -> (latitude: Double, longitude: Double)? {
        if let currentLocation = locationManager.location {
            return (latitude: currentLocation.coordinate.latitude as Double, longitude: currentLocation.coordinate.longitude as Double)
        } else {
            return nil
        }
    }
}
