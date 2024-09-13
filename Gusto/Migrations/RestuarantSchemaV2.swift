//
//  RestuarantSchemaV2.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/9/13.
//

import Foundation
import SwiftData

enum RestaurantSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)

    static var models: [any PersistentModel.Type] {
        [Restaurant.self]
    }

    @Model
    class Restaurant {
    
        // Erase All Content And Settings to clear the old data.
        // It's a breaking changes for the local DB when set up a unique, which we didn't set up for the existing DB data
        @Attribute(.unique) var name: String // It’s not a good practice to use name as the unique key, but let’s go with it for now since it’s just demo code for practice purposes.
        /*
         You should be very careful when using @Attribute(.unique) with any properties,
         because it is not supported when you want to store your user’s data in iCloud (which is most of the time!)
         */
    
        var priceRating: Int
        var qualityRating: Int
        var speedRating: Int
    
        var ranting: Int {
            (priceRating + qualityRating + speedRating) / 3
        }
    
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
