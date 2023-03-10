//
//  Meal.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation

struct Meal: Identifiable {
    var id: String
    var name: String
    var thumbNailImage: String
}

extension Meal: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbNailImage = "strMealThumb"
    }
}
