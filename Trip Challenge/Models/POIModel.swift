//
//  POIModel.swift
//  Trip Challenge
//
//  Created by Kate on 03/02/2024.
//

import Foundation
import RealmSwift

class POI: Object {
    @Persisted var poiCategory: String?
    @Persisted var poiDescription: String?
    @Persisted var poiID: Int
    @Persisted var poiImage: Data
    @Persisted var poiLat: Double
    @Persisted var poiLocation: String
    @Persisted var poiLon: Double
    @Persisted var poiNumber: Int16
    @Persisted var poiPromo: Bool
    @Persisted var poiStatus: String?
    @Persisted var poiTitle: String?
}
