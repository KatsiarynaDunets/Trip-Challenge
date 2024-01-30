//
//  Challenges+CoreDataProperties.swift
//  Trip Challenge
//
//  Created by Kate on 30/01/2024.
//
//

import Foundation
import CoreData


extension Challenges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenges> {
        return NSFetchRequest<Challenges>(entityName: "Challenges")
    }

    @NSManaged public var challengeAverageRating: Double
    @NSManaged public var challengeCategory: String?
    @NSManaged public var challengeDescription: String?
    @NSManaged public var challengeID: Int16
    @NSManaged public var challengeImage: Data?
    @NSManaged public var challengeLat: Double
    @NSManaged public var challengeLocation: String?
    @NSManaged public var challengeLon: Double
    @NSManaged public var challengeNumberOfPoints: Int32
    @NSManaged public var challengeRating: Int16
    @NSManaged public var challengeStatus: String?
    @NSManaged public var challengeTitle: String?
    @NSManaged public var pointsOfInterest: NSSet?

}

// MARK: Generated accessors for pointsOfInterest
extension Challenges {

    @objc(addPointsOfInterestObject:)
    @NSManaged public func addToPointsOfInterest(_ value: PointsOfInterest)

    @objc(removePointsOfInterestObject:)
    @NSManaged public func removeFromPointsOfInterest(_ value: PointsOfInterest)

    @objc(addPointsOfInterest:)
    @NSManaged public func addToPointsOfInterest(_ values: NSSet)

    @objc(removePointsOfInterest:)
    @NSManaged public func removeFromPointsOfInterest(_ values: NSSet)

}

extension Challenges : Identifiable {

}
