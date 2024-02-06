//
//  MapVC.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import MapKit
import UIKit

class MapVC: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    var challenges: [Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupMapAnnotationsAndRoutes()
        setupMap()
        createRoute()
    }
    
    private func setupMapAnnotationsAndRoutes() {
        for challenge in challenges {
            var previousPOI: POI?
            for poi in challenge.pointsOfInterest.sorted(by: { $0.poiNumber < $1.poiNumber }) {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: poi.poiLat, longitude: poi.poiLon)
                annotation.title = poi.poiTitle
                mapView.addAnnotation(annotation)
                
                if let prev = previousPOI {
                    let coordinates = [CLLocationCoordinate2D(latitude: prev.poiLat, longitude: prev.poiLon), annotation.coordinate]
                    let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                    mapView.addOverlay(polyline)
                }
                previousPOI = poi
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.systemMint
            renderer.lineWidth = 3.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    private func setupMap() {
        if let firstPOI = challenges.first?.pointsOfInterest.first {
            let initialLocation = CLLocationCoordinate2D(latitude: firstPOI.poiLat, longitude: firstPOI.poiLon)
            let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func createRoute() {
        guard let challenge = challenges.first, challenge.pointsOfInterest.count > 1 else { return }
        let coordinates = challenge.pointsOfInterest.map { CLLocationCoordinate2D(latitude: $0.poiLat, longitude: $0.poiLon) }
        
        // Creating an array of CLLocationCoordinate2D
        let coordinateArray = Array(coordinates)
        
        // Creating a polyline with the array of coordinates
        let polyline = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
        mapView.addOverlay(polyline)
    }
}
