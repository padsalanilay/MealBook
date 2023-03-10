//
//  MealDetails.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation

struct MealDetail {
    var id: String
    var name: String
    var alternateDrink: String?
    var category: String
    var area: String
    var instructions: String
    var thumbnailImageUrlString: String
    var tags: [String]
    var youtubeUrlString: String?
    var ingredients: [MealIngredient]
    var sourceUrlString: String?
    var imageSourceUrlString: String?
    var creativeCommonsConfirmed: String?
    var dateModified: String? // Could not find any date in few of the samples i checked, otherwise it would be Date object
}

struct MealIngredient: Decodable {
    var name: String
    var measure: String
}

extension MealDetail: Decodable {
    enum DecodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case alternateDrink = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnailImageUrlString = "strMealThumb"
        case tagsString = "strTags"
        case youtubeUrlString = "strYoutube"
        case sourceUrlString = "strSource"
        case imageSourceUrlString = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
//    static func decode(jsonData data: Data, with strategy: DecodingStategy)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.alternateDrink = try? container.decode(String.self, forKey: .alternateDrink)
        self.category = try container.decode(String.self, forKey: .category)
        self.area = try container.decode(String.self, forKey: .area)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.thumbnailImageUrlString = try container.decode(String.self, forKey: .thumbnailImageUrlString)
        self.youtubeUrlString = try? container.decode(String.self, forKey: .youtubeUrlString)
        self.sourceUrlString = try? container.decode(String.self, forKey: .sourceUrlString)
        self.imageSourceUrlString = try? container.decode(String.self, forKey: .imageSourceUrlString)
        self.creativeCommonsConfirmed = try? container.decode(String.self, forKey: .creativeCommonsConfirmed)
        self.dateModified = try? container.decode(String.self, forKey: .dateModified)
        
        let tagsString = try? container.decode(String.self, forKey: .tagsString)
        self.tags = tagsString?.split(separator: ",").map(String.init) ?? []
        
        self.ingredients = []
        for number in 1...20 {
            
            if let ingredientName = try? container.decode(String.self, forKey: DecodingKeys(stringValue: "strIngredient\(number)")!),
               let measure = try? container.decode(String.self, forKey: DecodingKeys(stringValue: "strMeasure\(number)")!),
               !measure.isEmpty, !ingredientName.isEmpty{
                
                self.ingredients.append(
                    MealIngredient(name: ingredientName, measure: measure)
                )
                
            }
            
        }
    }
}

extension MealDetail {
    var hasYouTubeUrl: Bool {
        if let urlString = self.youtubeUrlString, let _ = URL(string: urlString) {
            return true
        }
        
        return false
    }

    var hasSourceUrl: Bool {
        if let urlString = self.sourceUrlString, let _ = URL(string: urlString) {
            return true
        }
        
        return false
    }

}
