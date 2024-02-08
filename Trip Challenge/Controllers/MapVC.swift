//
//  MapVC.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import CoreLocation
import MapKit
import UIKit
import RealmSwift

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var mapView: MKMapView!
    

    var challenges: [Challenge] = []
   
    let databaseManager = DatabaseManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupMapAnnotationsAndRoutes()
        setupMap()
        setupMapView()
        fetchAndDisplayChallenges()
        configureLocationManager()
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
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
       
    private func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }
    
    private func fetchAndDisplayChallenges() {
        let challenges = databaseManager.fetchChallenges()
        challenges.forEach { challenge in
            let coordinate = CLLocationCoordinate2D(latitude: challenge.challengeLat, longitude: challenge.challengeLon)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = challenge.challengeTitle
            mapView.addAnnotation(annotation)
        }
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
        
        // array of CLLocationCoordinate2D
        let coordinateArray = Array(coordinates)
        
        // polyline with the array of coordinates
        let polyline = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
        mapView.addOverlay(polyline)
    }
    
    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
    
        let identifier = "Challenge"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    // MARK: - CLLocationManagerDelegate Methods
       
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
       
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted, .notDetermined:
            print("Локация не определена")
        @unknown default:
            fatalError("Проблемы с авторизацией")
        }
    }
}
