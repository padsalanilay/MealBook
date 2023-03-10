//
//  ContentView.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import SwiftUI

struct MealCategoriesListView: View {
    
    @ObservedObject private var viewModel = MealCategoriesListViewModel()
    
    @State private var selectedMealRow: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                categoryList()
                
                ForEach(self.viewModel.mealsList) { meal in
                    NavigationLink(destination: MealDetailsView(mealId: meal.id)) {
                        MealRowView(meal: meal)
                    }
                }
            }
            .navigationTitle("Meal Book")
            .tint(.primary)
            .onAppear {
                self.viewModel.loadMealCategories()
            }
            .onReceive(self.viewModel.$categories) { categories in
                if let firstCategory = categories.first {
                    self.viewModel.select(category: firstCategory)
                }
            }
            .background(Color(uiColor: .secondarySystemBackground))

        }
    }
    
    @ViewBuilder
    private func categoryList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.fixed(10))]) {
                ForEach(self.viewModel.categories, id: \.id) { category in
                    MealCategoryView(
                        category: category,
                        selectedCategoryID: self.$viewModel.selectedCategoryID
                    )
                    .onTapGesture {
                        self.viewModel.select(category: category)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MealCategoriesListView()
    }
}
