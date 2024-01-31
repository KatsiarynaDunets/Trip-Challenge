//
//  MapVC.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
        var mapView: MKMapView!

        // массив точек интереса
        var pointsOfInterest: [PointOfInterest] = []

    override func viewDidLoad() {
           super.viewDidLoad()

           mapView = MKMapView(frame: self.view.bounds)
           mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           mapView.delegate = self
           view.addSubview(mapView)

           setupMap()
           createRoute()
       }

    private func setupMap() {
        // Установка региона карты на первую точку интереса
        if let firstPOI = pointsOfInterest.first {
            let initialLocation = CLLocationCoordinate2D(latitude: firstPOI.poiLat, longitude: firstPOI.poiLon)
            let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }

        
        // Добавление аннотаций на карту для каждой точки интереса
        for poi in pointsOfInterest {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: poi.poiLat, longitude: poi.poiLon)
            annotation.title = poi.poiTitle
            mapView.addAnnotation(annotation)
        }
        
       private func createRoute() {
           guard pointsOfInterest.count > 1 else { return }

           let coordinates = pointsOfInterest.map { CLLocationCoordinate2D(latitude: $0.poiLat, longitude: $0.poiLon) }
           let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
           mapView.addOverlay(polyline)
       }

       // MARK: MKMapViewDelegate Methods

       func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           if let polyline = overlay as? MKPolyline {
               let renderer = MKPolylineRenderer(polyline: polyline)
               renderer.strokeColor = UIColor.blue
               renderer.lineWidth = 4.0
               return renderer
           }
           return MKOverlayRenderer(overlay: overlay)
       }
    }
}
     


            
    }
