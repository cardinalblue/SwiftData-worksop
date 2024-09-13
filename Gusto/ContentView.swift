//
//  ContentView.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    enum SortingMode: String, CaseIterable {
        case name
        case priceRating
        case qualityRating
        case speedRating

        var title: String {
            switch self {
            case .name:
                return "Name"
            case .priceRating:
                return "Price"
            case .qualityRating:
                return "Quality"
            case .speedRating:
                return "Speed"
            }
        }

        var sortDescriptor: SortDescriptor<Restaurant> {
            switch self {
            case .name:
                return SortDescriptor(\Restaurant.name)
            case .priceRating:
                return SortDescriptor(\Restaurant.priceRating)
            case .qualityRating:
                return SortDescriptor(\Restaurant.qualityRating)
            case .speedRating:
                return SortDescriptor(\Restaurant.speedRating)
            }
        }
    }

    enum FilterMode: String, CaseIterable {
        case none
        case priceRating
        case qualityRating
        case speedRating

        var title: String {
            rawValue
                .capitalized
                .replacingOccurrences(of: "Rating", with: "")
        }

        var predicate: Predicate<Restaurant> {
            switch self {
            case .none:
                return .true
            case .priceRating:
                return #Predicate { $0.priceRating > 150 }
            case .qualityRating:
                return #Predicate { $0.qualityRating > 3 }
            case .speedRating:
                return #Predicate { $0.speedRating > 3 }
            }
        }
    }

    @Environment(\.modelContext) var modelContext

    private let names: [String] = [
        "Wok this Way",
        "Thyme Square",
        "Pasta la Vista",
        "Life of Pie",
        "Lord of the Wings"
    ]

    @State
    private var sortingModes: [SortingMode] = [.name]

    @State
    private var filterMode: FilterMode = .none

    @State
    private var searchText: String = ""

    var body: some View {
        RestaurantListView(
            sortDescriptors: sortingModes.map { $0.sortDescriptor },
            filter: {
                guard !searchText.isEmpty else {
                    return filterMode.predicate
                }
                return #Predicate { $0.name.contains(searchText) }
            }()
        ).onDelete { restaurant in
            modelContext.delete(restaurant)
        }.searchable(text: $searchText)
        HStack {
            addRestaurantButton()
            sortingModesOptionButtons()
            filterModeSegmentedControl()
        }
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
                    priceRating: 100 * .random(in: 1...5),
                    qualityRating: .random(in: 1...5),
                    speedRating: .random(in: 1...5), 
                    dishes: []
                )
            }
            .forEach {
                modelContext.insert($0)
            }
    }

    // MARK: ViewBuilders

    @ViewBuilder
    private func addRestaurantButton() -> some View {
        Button(action: {
            createRestaurants(with: names)
        }, label: {
            Image(systemName: "plus.circle")
                .foregroundColor(.blue)
        })
    }

    @ViewBuilder
    private func sortingModesOptionButtons() -> some View {
        ForEach(SortingMode.allCases, id: \.self) { mode in
            Button(action: {
                if sortingModes.contains(mode) {
                    sortingModes.removeAll { $0 == mode }
                } else {
                    sortingModes.append(mode)
                }
            }, label: {
                Text(mode.title)
                    .tint(sortingModes.contains(mode) ? Color.blue : Color.gray)
            })
        }
    }

    @ViewBuilder
    private func filterModeSegmentedControl() -> some View {
        Picker("Filter Mode", selection: $filterMode) {
            ForEach(FilterMode.allCases, id: \.self) { mode in
                Text(mode.title)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}

#Preview {
    ContentView()
}
