//
//  APIMealList.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation

struct APIMealsList {
    var meals: [Meal]
}

extension APIMealsList: Codable {
    enum CodingKeys: String, CodingKey {
        case meals
    }
}
