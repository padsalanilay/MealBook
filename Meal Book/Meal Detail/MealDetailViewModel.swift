//
//  MealDetailViewModel.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import Foundation
import Combine

final class MealDetailsViewModel: ObservableObject {
    @Published var mealDetails: MealDetail? = nil

    private var cancellable = Set<AnyCancellable>()
        
    deinit {
        cancellable.removeAll()
    }
}

// API calls
extension MealDetailsViewModel {
    func loadMealDetail(for mealId: String) {
        let mealDetailsURLString: String = "https://www.themealdb.com/api/json/v1/1/lookup.php"
    
        return NetworkManager.shared.GET(
            mealDetailsURLString,
            queryParameters: ["i": mealId]
        )
        .replaceError(with: Data())
        .decode(type: APIMealDetails.self, decoder: JSONDecoder())
        .tryMap(\.meals)
        .catch({ error in
            Just([MealDetail]())
        })
        .map(\.first)
        .receive(on: RunLoop.main)
        .assign(to: \.mealDetails, on: self)
        .store(in: &cancellable)
    }
}

