//
//  MealCategory.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation
import Foundation

struct MealCategory: Identifiable {
    var id: String
    var name: String
    var thumbNailImage: String
    var description: String
}

extension MealCategory: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbNailImage = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
