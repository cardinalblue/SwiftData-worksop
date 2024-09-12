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

    @Query var restaurants: [Restaurant]

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
                ForEach(restaurants, id: \.self) {
                    Text(verbatim: $0.name)
                }
            }
        }
        Button(action: {
            createRestaurants(with: names)
        }, label: {
            // an Image with the SFSymbol named "plus.circle"
            Image(systemName: "plus.circle")
                .foregroundColor(.blue)
        })
    }
}

// MARK: Private functions
extension ContentView {

    private func createRestaurants(with names: [String]) {
        names
            .map { name in
                Restaurant(
                    name: name,
                    priceRating: 300,
                    qualityRating: 1,
                    speedRating: 1
                )
            }
            .forEach {
                modelContext.insert($0)
            }
    }
}

#Preview {
    ContentView()
}
