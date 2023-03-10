//
//  MealCategoriesListViewModel.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation
import Combine

final class MealCategoriesListViewModel: ObservableObject {
    @Published var categories: [MealCategory] = []

    @Published var mealsList: [Meal] = []
    @Published var selectedCategoryID: String = "-1"

    private var cancellable = Set<AnyCancellable>()
        
    deinit {
        cancellable.removeAll()
    }
}

extension MealCategoriesListViewModel {
    func select(category: MealCategory) {
        self.selectedCategoryID = category.id
        self.loadMeals(for: category.name)
    }

}

// API calls
extension MealCategoriesListViewModel {
    func loadMeals(for categoryName: String) {
        let mealsListURLString: String = "https://www.themealdb.com/api/json/v1/1/filter.php"
    
        return NetworkManager.shared.GET(
            mealsListURLString,
            queryParameters: ["c": categoryName]
        )
        .replaceError(with: Data())
        .decode(type: APIMealsList.self, decoder: JSONDecoder())
        .tryMap(\.meals)
        .catch({ error in
            Just([Meal]())
        })
        .map{ $0.sorted { $0.name < $1.name } }
        .receive(on: RunLoop.main)
        .assign(to: \.mealsList, on: self)
        .store(in: &cancellable)

    }

    func loadMealCategories() {
        let mealCategoriesURLString: String = "https://www.themealdb.com/api/json/v1/1/categories.php"
        NetworkManager.shared.GET(
            mealCategoriesURLString,
            queryParameters: nil
        )
        .replaceError(with: Data())
        .decode(type: APIMealCategoriesList.self, decoder: JSONDecoder())
        .tryMap(\.categories)
        .catch({ error in
            Just([MealCategory]())
        })
        .map{ $0.sorted { $0.name < $1.name } }
        .receive(on: RunLoop.main)
        .assign(to: \.categories, on: self)
        .store(in: &cancellable)
    }

}

