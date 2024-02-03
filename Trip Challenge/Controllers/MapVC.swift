//
//  MapVC.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import UIKit
import MapKit

class MapVC:

    UIViewController, MKMapViewDelegate {
        @IBOutlet var mapView: MKMapView!

        var challenges: [Challenge] = [] //Challenge содержит массив POI

        override func viewDidLoad() {
            super.viewDidLoad()
            mapView.delegate = self
//            setupMapAnnotationsAndRoutes()
        }

//        private func setupMapAnnotationsAndRoutes() {
//            for challenge in challenges {
//                var previousPOI: POI?
//                for poi in challenge.pointsOfInterest.sorted(by: { $0.poiNumber < $1.poiNumber }) {
//                    let annotation = MKPointAnnotation()
//                    annotation.coordinate = CLLocationCoordinate2D(latitude: poiLat, longitude: poiLon)
//                    annotation.title = poiTitle
//                    mapView.addAnnotation(annotation)
//
//                    if let prev = previousPOI {
//                        let coordinates = [CLLocationCoordinate2D(latitude: prev.latitude, longitude: prev.longitude), annotation.coordinate]
//                        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
//                        mapView.addOverlay(polyline)
//                    }
//                    previousPOI = poi
//                }
//            }
//        }

        // MKMapViewDelegate methods to render overlay
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.systemMint // Цвет маршрута
                renderer.lineWidth = 3.0 // Толщина линии
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
    
//    UIViewController, MKMapViewDelegate {
//        var mapView: MKMapView!
//
//        // массив точек интереса
//        var pointsOfInterest: [PointsOfInterest] = []
//
//    override func viewDidLoad() {
//           super.viewDidLoad()
//
//           mapView = MKMapView(frame: self.view.bounds)
//           mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//           mapView.delegate = self
//           view.addSubview(mapView)
//
//           setupMap()
//           createRoute()
//       }
//
//    private func setupMap() {
//        // Установка региона карты на первую точку интереса
//        if let firstPOI = pointsOfInterest.first {
//            let initialLocation = CLLocationCoordinate2D(latitude: firstPOI.poiLat, longitude: firstPOI.poiLon)
//            let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
//            mapView.setRegion(region, animated: true)
//        }
//
//
//        // Добавление аннотаций на карту для каждой точки интереса
//        for poi in pointsOfInterest {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: poi.poiLat, longitude: poi.poiLon)
//            annotation.title = poi.poiTitle
//            mapView.addAnnotation(annotation)
//        }
//
//       private func createRoute() {
//           guard pointsOfInterest.count > 1 else { return }
//
//           let coordinates = pointsOfInterest.map { CLLocationCoordinate2D(latitude: $0.poiLat, longitude: $0.poiLon) }
//           let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
//           mapView.addOverlay(polyline)
//       }
//
//       // MARK: MKMapViewDelegate Methods
//
//       func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//           if let polyline = overlay as? MKPolyline {
//               let renderer = MKPolylineRenderer(polyline: polyline)
//               renderer.strokeColor = UIColor.blue
//               renderer.lineWidth = 4.0
//               return renderer
//           }
//           return MKOverlayRenderer(overlay: overlay)
//       }
//    }
//}
//
//
//
//
//
