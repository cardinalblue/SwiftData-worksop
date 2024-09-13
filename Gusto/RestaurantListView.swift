//
//  RestaurantListView.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/9/13.
//

import SwiftUI
import SwiftData

struct RestaurantListView: View {

    @Query private var restaurants: [Restaurant]
    @State private var onDeletion: ((Restaurant) -> Void)?

    init(sortDescriptors: [SortDescriptor<Restaurant>], filter: Predicate<Restaurant>) {
        _restaurants = Query(filter: filter, sort: sortDescriptors)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants, id: \.self) { restaurant in
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
    }

    func onDelete(perform action: @escaping (Restaurant) -> Void) -> some View {
        self.onDeletion = action
        return self
    }
}

// MARK: - Private functions
extension RestaurantListView {
    private func removeRestaurants(for indexSet: IndexSet) {
        indexSet.map { restaurants[$0] }.forEach { restaurant in
            onDeletion?(restaurant)
        }
    }
}

#Preview {
    RestaurantListView(sortDescriptors: [], filter: .true)
}
