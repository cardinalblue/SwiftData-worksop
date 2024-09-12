//
//  Restaurant.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/3/24.
//

import Foundation
import SwiftData
import Observation

@Model
class Restaurant {
    var name: String
    var priceRating: Int
    var qualityRating: Int
    var speedRating: Int
    
    init(name: String, priceRating: Int, qualityRating: Int, speedRating: Int) {
        self.name = name
        self.priceRating = priceRating
        self.qualityRating = qualityRating
        self.speedRating = speedRating
    }
}
