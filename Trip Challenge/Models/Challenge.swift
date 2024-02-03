////
////  Challenge.swift
////  Trip Challenge
////
////  Created by Kate on 19/11/2023.
////
//
//import Foundation
//import CoreData
//
//@objc(Challenge)
//public class Challenge: NSManagedObject {
//    @NSManaged public var challengeAverageRating: Double
//    @NSManaged public var challengeCategory: String?
//    @NSManaged public var challengeDescription: String?
//    @NSManaged public var challengeID: Int16
//    @NSManaged public var challengeImage: Data?
//    @NSManaged public var challengeLat: Double
//    @NSManaged public var challengeLocation: String?
//    @NSManaged public var challengeLon: Double
//    @NSManaged public var challengeNumberOfPoints: Int32
//    @NSManaged public var challengeRating: Int16
//    @NSManaged public var challengeStatus: String?
//    @NSManaged public var challengeTitle: String?
//    @NSManaged public var pointsOfInterest: NSSet?
//
//    // Добавление точки интереса к челленджу
//    func addToPointsOfInterest(_ value: PointsOfInterest) {
////        let items = self.mutableSetValue(forKey: "pointsOfInterest")
//        items.add(value)
//    }
//
//    // Удаление точки интереса из челленджа
//    func removeFromPointsOfInterest(_ value: PointsOfInterest) {
//        let items = self.mutableSetValue(forKey: "pointsOfInterest")
//        items.remove(value)
//    }
//
//    // Получение всех точек интереса
//    func getPointsOfInterest() -> [PointsOfInterest]? {
//        return pointsOfInterest?.allObjects as? [PointsOfInterest]
//    }
//}
//
////// Расширение для удобства работы с данными
////extension Challenge {
////    // Функция для создания нового челленджа
////    static func createChallenge(in context: NSManagedObjectContext, id: Int16, title: String, description: String, category: String, latitude: Double, longitude: Double, image: Data) -> Challenge {
////        let challenge = Challenge(context: context)
////        challenge.challengeID = id
////        challenge.challengeTitle = title
////        challenge.challengeDescription = description
////        challenge.challengeCategory = category
////        challenge.challengeLat = latitude
////        challenge.challengeLon = longitude
////        challenge.challengeImage = image
////        return challenge
////    }
////}
