//
//  APIMealDetails.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation

struct APIMealDetails {
    var meals: [MealDetail]
}

extension APIMealDetails: Decodable {
    enum CodingKeys: String, CodingKey {
        case meals
    }
}
