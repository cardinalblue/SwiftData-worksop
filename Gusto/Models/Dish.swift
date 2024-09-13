//
//  Dish.swift
//  Gusto
//
//  Created by Chiaote Ni on 2024/9/13.
//

import Foundation
import SwiftData

@Model
class Dish {
    var name: String
    var review: String

    init(name: String, review: String) {
        self.name = name
        self.review = review
    }
}

