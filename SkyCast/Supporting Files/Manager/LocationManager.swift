//
//  LocationManager.swift
//  SkyCast
//
//  Created by Owais on 12/12/24.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var locationCompletion: ((CLLocation?, Error?) -> Void)?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchCurrentLocation(completion: @escaping (CLLocation?, Error?) -> Void) {
        locationCompletion = completion
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            locationCompletion?(nil, NSError(domain: "LocationError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location access not granted"]))
        }
    }
    
    func fetchLocationDetails(completion: @escaping (String?, String?, String?, Error?) -> Void) {
        fetchCurrentLocation { location, error in
            if let error = error {
                completion(nil, nil, nil, error)
            } else if let location = location {
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let error = error {
                        completion(nil, nil, nil, error)
                    } else if let placemark = placemarks?.first {
                        let country = placemark.country
                        let state = placemark.administrativeArea
                        let city = placemark.locality
                        completion(country, state, city, nil)
                    } else {
                        completion(nil, nil, nil, NSError(domain: "LocationError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch placemark"]))
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location = locations.last {
            locationCompletion?(location, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        locationCompletion?(nil, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.authorizationStatus() == .denied {
            locationCompletion?(nil, NSError(domain: "LocationError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Location access denied"]))
        }
    }
}
