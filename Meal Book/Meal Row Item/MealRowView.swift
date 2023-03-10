//
//  MealRowView.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import SwiftUI

struct MealRowView: View {
    var meal: Meal
    
    private var mealURL: URL? {
        if let url = URL(string: self.meal.thumbNailImage + "/preview") {
            return url
        }
        
        return nil
    }
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: mealURL) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(10)
            .padding(10)
    
            Text(self.meal.name)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .background(Color(uiColor: .systemBackground))
        .padding(.horizontal)
    }
}

struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        MealRowView(meal: Meal(id: "1", name: "Sandwich", thumbNailImage: "some image"))
            .padding()
    }
}
