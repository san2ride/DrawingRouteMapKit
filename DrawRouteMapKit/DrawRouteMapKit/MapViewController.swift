//
//  MapViewController.swift
//  DrawRouteMapKit
//
//  Created by don't touch me on 10/19/16.
//  Copyright © 2016 trvl, LLC. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //1 viewController is the delegate of the MKMapViewDelegate protocol
        mapView.delegate = self
        
        //2 set the lat/long of the locations
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
        
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        
        //3 create placemark objects containing the locations coordinates
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        //4 MKMapitems are used for routing
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        //5 annotations are added which shows the name of the placemarks
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Times Square"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        //6 annotations are displayed on the map
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true)
        
        //7 MKDirectionsRequest class is used to compute the route
        let directRequest = MKDirectionsRequest()
        directRequest.source = sourceMapItem
        directRequest.destination = destinationMapItem
        directRequest.transportType = .automobile
        
        // Calculate the directions
        let directions = MKDirections(request: directRequest)

        //8 route will be drawn using polyline as a overlay view on top of the map
        directions.calculate(completionHandler:) {
            
            (response, error) -> Void in
            
            guard let response = response else {
                
                if let error = error {
                    
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
    

    
}
