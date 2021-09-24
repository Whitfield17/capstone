//
//  LocationViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    static let shared = LocationViewModel()
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var placemark: CLPlacemark?
    
    override init() {
        //Init method of NSObject
        super.init()
        
        //Set location model as the delegate of the location manager
        locationManager.delegate = self
        
    }
    
    //MARK: - Location Manager Delegate Methods
    
    func requestGeolocationPermission() {
        
        //Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            //We have permission
            //Start geolocating the user, after we get permission
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
            
            //We dont have permission
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Gives us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            
            //We have a location
            //Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            //Get the placemark of the user
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation!) { (placemarks, error) in
                
                //Check that there aren't error
                if error == nil && placemarks != nil {
                    
                    //Take the first placemark
                    self.placemark = placemarks?.first
                }
            }
        }
    }
}
