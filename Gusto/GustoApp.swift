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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Restaurant.self)
    }
}
