//
//  RestaurantMigrationPlan.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/9/13.
//

import Foundation
import SwiftData

enum RestaurantMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [RestaurantSchemaV1.self, RestaurantSchemaV2.self]
    }

    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: RestaurantSchemaV1.self,
        toVersion: RestaurantSchemaV2.self,
        willMigrate: { context in
            let restaurants = try context.fetch(FetchDescriptor<RestaurantSchemaV1.Restaurant>())
            var restaurantNames = Set<String>()
            
            for restaurant in restaurants {
                if restaurantNames.contains(restaurant.name) {
                    context.delete(restaurant)
                } else {
                    restaurantNames.insert(restaurant.name)
                }
            }
            try context.save()
        }, didMigrate: nil
    )
}
