//
//  PointsOfInterest+CoreDataProperties.swift
//  Trip Challenge
//
//  Created by Kate on 24/01/2024.
//
//

import Foundation
import CoreData


extension PointsOfInterest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PointsOfInterest> {
        return NSFetchRequest<PointsOfInterest>(entityName: "PointsOfInterest")
    }

    @NSManaged public var poiTitle: String?
    @NSManaged public var poiDescription: String?
    @NSManaged public var poiCategory: String?
    @NSManaged public var poiID: Int16
    @NSManaged public var poiNumber: Int16
    @NSManaged public var poiImage: Data?
    @NSManaged public var poiStatus: Bool
    @NSManaged public var poiLat: Double
    @NSManaged public var poiLon: Double
    @NSManaged public var poiPromo: Bool
    @NSManaged public var poiLocation: String?

}

extension PointsOfInterest : Identifiable {

}
