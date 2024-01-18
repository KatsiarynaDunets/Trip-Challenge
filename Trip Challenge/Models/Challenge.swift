//
//  Challenge.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//

import Foundation
import CoreLocation
// Challenge Model
struct Challenge {
    var id: Int
    var title: String
    var location: String
    var description: String
    let coordinate: CLLocationCoordinate2D //coordinate не изменяется после инициализации
    
    init(id: Int, title: String, location: String, description: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.location = location
        self.description = description
        self.coordinate = coordinate
    }
}

extension Challenge {
    func calculateDistance(from userLocation: CLLocation) -> CLLocationDistance {
        let challengeLocation = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        return challengeLocation.distance(from: userLocation)
    }
}
