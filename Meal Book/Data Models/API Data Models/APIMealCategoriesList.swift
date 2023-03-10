//
//  APIMealCategoriesList.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation

struct APIMealCategoriesList {
    var categories: [MealCategory]
}

extension APIMealCategoriesList: Codable {
    enum CodingKeys: String, CodingKey {
        case categories
    }
}
