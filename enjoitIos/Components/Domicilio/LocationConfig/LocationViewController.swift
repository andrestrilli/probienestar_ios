//
//  LocationViewController.swift
//  enjoitIos
//
//  Created by developapp on 11/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationViewController:UIViewController, ObservableObject{
    
    let locationManager = CLLocationManager()
    @Published var location:CLLocation?
    @Published var locationString:String?
    var isUpdatingLocation = false
    var lastLocationError: Error?
    
    //GeoCoder
    let geocoder = CLGeocoder()
    var placemark : CLPlacemark?
    @Published var isPerformingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    
    func updateUI(){
        if let location = location {
            print("location \(location)")
        }else{
            // si location es null
            print("location \(location)")

        }
        
    }
    
    func getAddress(from placemark: CLPlacemark)->String{
        
        var linea1 = ""
        if let street1 = placemark.subThoroughfare{
            linea1 += street1 + ""
        }
        if let street2 = placemark.thoroughfare{
            linea1 += street2 + ""
        }
        var linea2 = ""
        if let city = placemark.locality{
            linea2 += city + ""
        }
        if let country = placemark.country{
            linea2 += country + ""
        }
        
        return linea1 + "\n" + linea2
        
    }
    
    func findLocation(){
        // 1 - get the users permission for use location servicers
        let authStatus  = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // 2 - report to user if permission is denied
        if authStatus == .denied || authStatus == .restricted{
            reportLocatioServiceDenied()
            return
        }
        
        // 3 - star/ stop finding location
        if  isUpdatingLocation{
            stopLocationManager()
        }else{
            lastLocationError = nil
            placemark = nil
            lastGeocodingError = nil
            startLocationManager()
        }
        
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            isUpdatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if  isUpdatingLocation{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            isUpdatingLocation = false
        }
    }

    
    func reportLocatioServiceDenied() {
        print("Acceso denegado")
        let alert = UIAlertController(title: "Permiso Denegado", message: "Por favor habilite los servicios para obtener la ubicacion desde esta app", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension LocationViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("didFailWithError \(error)")
        if (error as NSError).code == CLError.locationUnknown.rawValue{
            return
        }
        lastLocationError = error
        stopLocationManager()
        updateUI()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        print("hecha la actualizacion \(location)")
        stopLocationManager()
        updateUI()
        
        if location != nil{
            if !isPerformingReverseGeocoding{
                print("HAciendo geocoding")
                isPerformingReverseGeocoding = true;
                geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                    self.lastGeocodingError = error
                    if  error == nil , let placemarks = placemarks, !placemarks.isEmpty {
                        self.placemark = placemarks.last!
                        self.locationString = self.getAddress(from: self.placemark!)
                    }else{
                        self.placemark = nil
                    }
                    
                    self.isPerformingReverseGeocoding =  false;
                    self.updateUI()
                }
            }
        }
    }
}
