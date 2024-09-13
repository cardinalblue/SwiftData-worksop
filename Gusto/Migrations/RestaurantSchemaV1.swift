//
//  RestaurantSchemaV1.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/9/13.
//

import Foundation
import SwiftData

enum RestaurantSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [Restaurant.self]
    }

    @Model
    class Restaurant {
        var name: String
        var priceRating: Int
        var qualityRating: Int
        var speedRating: Int

        var dishes: [Dish]

        init(name: String, priceRating: Int, qualityRating: Int, speedRating: Int, dishes: [Dish] = []) {
            self.name = name
            self.priceRating = priceRating
            self.qualityRating = qualityRating
            self.speedRating = speedRating
            self.dishes = dishes
        }
    }
}
