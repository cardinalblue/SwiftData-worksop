//
//  GustoApp.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/3/24.
//

import SwiftUI
import SwiftData

@main
struct GustoApp: App {

    var modelContainer: ModelContainer = {
        let config = ModelConfiguration(
            schema: Schema([Restaurant.self], version: Schema.Version(2, 0, 0))
        )
        do {
            return try ModelContainer(
                for: Restaurant.self,
                migrationPlan: RestaurantMigrationPlan.self,
                configurations: config
            )
        } catch {
            debugPrint(error)
            fatalError("Failed to initialize model container.")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(modelContainer)
    }
}
