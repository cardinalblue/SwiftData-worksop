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
            Button("Add Dish") {
                restaurant.dishes.append(Dish(name: "", review: ""))
            }
            VStack {
                Text("Dishes")
                ScrollView(.horizontal, showsIndicators: true) {
                    ForEach(restaurant.dishes, id: \.self) { dish in
                        VStack {
                            TextField(
                                "Name",
                                text: Binding(get: { dish.name }, set: { dish.name = $0 })
                            )
                            TextField(
                                "Review",
                                text: Binding(get: { dish.review }, set: { dish.review = $0 })
                            )
                        }
                    }
                }
            }
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
        speedRating: 3,
        dishes: []
    )
    return EditRestaurantView(restaurant: restaurant)
        .modelContainer(container)
}
