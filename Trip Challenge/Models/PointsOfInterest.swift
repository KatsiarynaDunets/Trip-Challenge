//
//  PointsOfInterest.swift
//  Trip Challenge
//
//  Created by Kate on 21/01/2024.
//

//import Foundation
//import CoreData
//import MapKit
//
//@objc(PointOfInterest)
//public class PointsOfInterest: NSManagedObject {
//    @NSManaged public var poiCategory: String?
//    @NSManaged public var poiDescription: String?
//    @NSManaged public var poiID: Int32
//    @NSManaged public var poiImage: Data?
//    @NSManaged public var poiLat: Double
//    @NSManaged public var poiLocation: String?
//    @NSManaged public var poiLon: Double
//    @NSManaged public var poiNumber: Int16
//    @NSManaged public var poiPromo: Bool
//    @NSManaged public var poiStatus: String?
//    @NSManaged public var poiTitle: String?
////    @NSManaged public var challenge: Challenge?
//    }
//
//// Расширение для удобства работы с данными
//extension PointsOfInterest {
//    // Функция для создания новой точки интереса
//    static func createPointOfInterest(in context: NSManagedObjectContext, id: Int32, title: String, description: String, category: String, latitude: Double, longitude: Double, image: Data, promo: Bool) -> PointsOfInterest {
//        let pointOfInterest = PointsOfInterest(context: context)
//        pointOfInterest.poiID = id
//        pointOfInterest.poiTitle = title
//        pointOfInterest.poiDescription = description
//        pointOfInterest.poiCategory = category
//        pointOfInterest.poiLat = latitude
//        pointOfInterest.poiLon = longitude
//        pointOfInterest.poiImage = image
//        pointOfInterest.poiPromo = promo
//        return pointOfInterest
//    }
//
////    // Метод для получения связанных челленджей
////    func getAssociatedChallenges() -> [Challenge]? {
////        return challenges?.allObjects as? [Challenge]
////    }
//}
//
//
//
//    
