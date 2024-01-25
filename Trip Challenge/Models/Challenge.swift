//
//  Challenge.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//

import CoreData
import CoreLocation

@objc(Challenge)
public class Challenge: NSManagedObject {
    @NSManaged public var challengeAverageRating: Double
    @NSManaged public var challengeCategory: String
    @NSManaged public var challengeDescription: String
    @NSManaged public var challengeId: Int16
    @NSManaged public var challengeImage: Data
    @NSManaged public var challengeLat: Double
    @NSManaged public var challengeLocation: String
    @NSManaged public var challengeLon: Double
    @NSManaged public var challengeNumberOfPoints: Int16
    @NSManaged public var challengeRating: Int16
    @NSManaged public var challengeTitle: String
    @NSManaged public var challengeStatus: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: challengeLat, longitude: challengeLon)
    }
}

extension Challenge {
    func calculateDistance(from userLocation: CLLocation) -> CLLocationDistance {
        let challengeLocation = CLLocation(latitude: self.challengeLat, longitude: self.challengeLon)
        return challengeLocation.distance(from: userLocation)
    }
    
    func calculateDistanceToNearestPoint(from userLocation: CLLocation) -> CLLocationDistance? {
            //у Challenge есть связь с PointsOfInterest
            // у PointsOfInterest есть свойство 'coordinate'
            guard let pointsOfInterest = self.pointsOfInterest as? Set<PointsOfInterest>, !pointsOfInterest.isEmpty else {
                return nil
            }

            let distances = pointsOfInterest.map { poi in
                CLLocation(latitude: poi.latitude, longitude: poi.longitude).distance(from: userLocation)
            }

            return distances.min()
        }
    
}

//    struct Challenge {
//    var id: Int
//    var title: String
//    var location: String
//    var description: String
//    let coordinate: CLLocationCoordinate2D //coordinate не изменяется после инициализации
//
//    init(id: Int, title: String, location: String, description: String, coordinate: CLLocationCoordinate2D) {
//        self.id = id
//        self.title = title
//        self.location = location
//        self.description = description
//        self.coordinate = coordinate
//    }
//}

//extension Challenge {
//    func calculateDistance(from userLocation: CLLocation) -> CLLocationDistance {
//        let challengeLocation = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
//        return challengeLocation.distance(from: userLocation)
//    }
//}

