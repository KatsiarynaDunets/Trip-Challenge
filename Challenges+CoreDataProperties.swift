//
//  Challenges+CoreDataProperties.swift
//  Trip Challenge
//
//  Created by Kate on 24/01/2024.
//
//

import Foundation
import CoreData


extension Challenges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenges> {
        return NSFetchRequest<Challenges>(entityName: "Challenges")
    }

    @NSManaged public var challengeTitle: String?
    @NSManaged public var challengeDescription: String?
    @NSManaged public var challengeLat: Int16
    @NSManaged public var challengeLon: Int16
    @NSManaged public var challengeNumberOfPoints: Int16
    @NSManaged public var challengeCategory: String?
    @NSManaged public var challengeImage: Data?
    @NSManaged public var challengeID: Int16
    @NSManaged public var challengeRating: Int16
    @NSManaged public var challengeAverageRating: Double
    @NSManaged public var challengeLocation: String?
    @NSManaged public var challengeStatus: Bool

}

extension Challenges : Identifiable {

}
