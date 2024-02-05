//
//  ChallengeModel.swift
//  Trip Challenge
//
//  Created by Kate on 03/02/2024.
//
import Foundation
import RealmSwift

class Challenge: Object {
    @Persisted var challengeAverageRating: Double = 0.0
    @Persisted var challengeCategory: String?
    @Persisted var challengeDescription: String?
    @Persisted var challengeID: Int16
    @Persisted var challengeImage: Data?
    @Persisted var challengeLat: Double
    @Persisted var challengeLocation: String?
    @Persisted var challengeLon: Double
    @Persisted var challengeNumberOfPoints: Int32
    @Persisted var challengeRating: Double
    @Persisted var challengeStatus: String?
    @Persisted var challengeTitle: String?
    @Persisted var pointsOfInterest: RealmSwift.List<POI>
}
