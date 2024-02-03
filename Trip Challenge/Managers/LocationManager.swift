//
//  LocationManager.swift
//  Trip Challenge
//
//  Created by Kate on 31/01/2024.
//


import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?

    var locationUpdateHandler: ((CLLocation) -> Void)?

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }

    // MARK: CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            locationUpdateHandler?(location)
//            MainVC.shared.fetchChallenges()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Доступ к местоположению запрещен")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}

//Singleton Pattern: LocationManager реализован как singleton для обеспечения единственного экземпляра этого класса в приложении.
//
//CLLocationManager: Используется для получения и отслеживания местоположения пользователя.
//
//Location Update Handler: locationUpdateHandler - это closure, который может быть установлен в контроллере для обработки обновлений местоположения.
//
//Запрос Разрешения: Класс запрашивает разрешение пользователя на использование геолокации и начинает обновление местоположения после получения разрешения.
//
//CLLocationManagerDelegate: Методы делегата обрабатывают обновления местоположения и ошибки.
