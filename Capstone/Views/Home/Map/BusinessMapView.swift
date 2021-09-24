//
//  BusinessMapView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-24.
//

import SwiftUI
import MapKit

struct BusinessMapView: UIViewRepresentable {
    @ObservedObject var businessListViewModel = BusinessListViewModel()
    @Binding var selectedBusiness: Business?
    
    var locations: [MKPointAnnotation] {
        
        var annotations = [MKPointAnnotation]()
        
        //Create a set of annotations from our list of businesses
        for business in businessListViewModel.businesses {
            
            let lat = business.latitude
            let long = business.longitude
            
            //If the business has a lat/long create an MKPointAnnotation for it
            if lat != 0.0 && long != 0.0 {
                
                //Create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.businessName
                
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        //Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
                
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        //Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        //Add the ones based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
    }
    
    //MARK: - Coordinator Class
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var map: BusinessMapView
        
        init(map: BusinessMapView) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            //If the annotation is the user location, return nil
            if annotation is MKUserLocation {
                return nil
            }
            
            //Check if there is a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.ANNOTATION_REUSE_ID)
            
            if annotationView == nil {
                
                //Create a new annotation view
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.ANNOTATION_REUSE_ID)
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                
                //We got a reusable annotation view
                annotationView!.annotation = annotation
            }
        
            //Return it
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            //User tapped on the annotation view
            
            //Get the business object that this annotation represents
            //Loop through businesses in the model and find a match
            for business in map.businessListViewModel.businesses {
                
                if business.businessName == view.annotation?.title {
                    
                    //Set the selectedBusiness property to that business object
                    map.selectedBusiness = business
                    return
                    
                }
            }
        }
    }
}
