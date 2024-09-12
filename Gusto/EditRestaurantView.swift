//
//  EditRestaurantView.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/3/24.
//

import SwiftUI
import SwiftData

struct EditRestaurantView: View {

    @Bindable var restaurant: Restaurant

    var body: some View {
        Text(verbatim: restaurant.name)
        Form {
            TextField("Name", text: $restaurant.name)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self, configurations: config)

    let restaurant = Restaurant(
        name: "yo",
        priceRating: 1,
        qualityRating: 2,
        speedRating: 3
    )
    return EditRestaurantView(restaurant: restaurant)
        .modelContainer(container)
}
