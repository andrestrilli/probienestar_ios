//
//  MapView.swift
//  enjoitIos
//
//  Created by developapp on 11/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias Context = UIViewRepresentableContext<Self>
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotation: MKPointAnnotation
    let mapView:MKMapView?

     func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        if let mapView = self.mapView {
            //let mapView = MKMapView()
            mapView.delegate = context.coordinator
            return mapView
        }
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
     }

     func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>){

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
        
       
        
    }
}
