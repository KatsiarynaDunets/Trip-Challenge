//
//  PointsOfInterest.swift
//  Trip Challenge
//
//  Created by Kate on 21/01/2024.
//

import CoreData
import CoreLocation

@objc(PointsOfInterest)
public class PointsOfInterest: NSManagedObject {
   
    @NSManaged public var poiCategory: String
    @NSManaged public var poiDescription: String
    @NSManaged public var poiID: Int16
    @NSManaged public var poiImage: Data
    @NSManaged public var poiLat: Double
    @NSManaged public var poiLocation: String
    @NSManaged public var poiLon: Double
    @NSManaged public var poiNumber: Int16
    @NSManaged public var poiPromo: Bool
    @NSManaged public var poiStatus: Bool
    @NSManaged public var poiTitle: String

    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: poiLat, longitude: poiLon)
        }

        func calculateDistance(from userLocation: CLLocation) -> CLLocationDistance {
            let poiLocation = CLLocation(latitude: self.poiLat, longitude: self.poiLon)
            return poiLocation.distance(from: userLocation)
        }
    }
