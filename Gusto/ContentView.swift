//
//  ContentView.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) var modelContext

    @Query(
        filter: #Predicate { $0.priceRating > 0 },
        sort: [
            SortDescriptor(\Restaurant.name),
            SortDescriptor(\Restaurant.priceRating, order: .reverse)
        ]
    ) var restaurants: [Restaurant]

    let names: [String] = [
        "Wok this Way",
        "Thyme Square",
        "Pasta la Vista",
        "Life of Pie",
        "Lord of the Wings"
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants, id: \.name) { restaurant in
                    NavigationLink {
                        EditRestaurantView(restaurant: restaurant)
                    } label: {
                        Text(verbatim: restaurant.name)
                        Text(verbatim: "\(restaurant.ranting)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }.onDelete(perform: { indexSet in
                    removeRestaurants(for: indexSet)
                })
            }
        }
        Button(action: {
            createRestaurants(with: names)
        }, label: {
            Image(systemName: "plus.circle")
                .foregroundColor(.blue)
        })
    }
}

// MARK: Private functions
extension ContentView {

    private func createRestaurants(with names: [String]) {
        names
            .enumerated()
            .map { index, name in
                Restaurant(
                    name: name,
                    priceRating: 300 * index,
                    qualityRating: 1,
                    speedRating: 1
                )
            }
            .forEach {
                modelContext.insert($0)
            }
    }

    private func removeRestaurants(for indexSet: IndexSet) {
        indexSet.forEach { index in
            let restaurant = restaurants[index]
            modelContext.delete(restaurant)
        }
    }
}

#Preview {
    ContentView()
}
