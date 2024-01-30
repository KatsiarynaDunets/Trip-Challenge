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
    @NSManaged public var challengeId: Int32
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
    
    //у Challenge есть связь с PointsOfInterest
    //у PointsOfInterest есть свойство 'coordinate'
//        func calculateDistanceToNearestPoint(from userLocation: CLLocation) -> CLLocationDistance? {
//            guard let pointsOfInterest = self.pointsOfInterest as? Set<PointsOfInterest>, !pointsOfInterest.isEmpty else {
//                return nil
//            }
//
//            let distances = pointsOfInterest.map { poi in
//                CLLocation(latitude: poi.latitude, longitude: poi.longitude).distance(from: userLocation)
//            }
//
//            return distances.min()
//        }
}

