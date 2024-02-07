//
//  NavigationManager.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023

import Foundation
import MapKit

class NavigationManager: NSObject, MKMapViewDelegate {
    var mapView: MKMapView
    
    init(mapView: MKMapView) {
        self.mapView = mapView
        super.init()
        mapView.delegate = self
    }
    
    func showChallengeLocation(challenge: Challenge) -> Result<Void, AppError> {
        guard let location = getLocationFromString(challenge.challengeLocation!) else {
            return .failure(.invalidLocation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = challenge.challengeTitle
        annotation.subtitle = challenge.challengeCategory
        mapView.addAnnotation(annotation)
        
        //         Центрирование карты на местоположении челленджа
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5, longitudinalMeters: 5)
        mapView.setRegion(region, animated: true)
        
        return .success(())
    }
    
    private func getLocationFromString(_ locationString: String) -> CLLocationCoordinate2D? {
        let coordinates = locationString.components(separatedBy: ",").compactMap { Double($0.trimmingCharacters(in: .whitespaces)) }
        guard coordinates.count == 2 else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
    }
    // }
    
    // Пример использования с обработкой ошибок
//    let mapView = MKMapView()
//    let navigationManager = NavigationManager(mapView: mapView)
//    if case `let` Result.failure(error) = navigationManager.showChallengeLocation(challenge: challenge1) {
//        print("Error: \(error)")
//    }
}
