//
//  MealDetailsView.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import SwiftUI

struct MealDetailsView: View {
    var mealId: String
    @ObservedObject private var viewModel = MealDetailsViewModel()
    
    private var imageURL: URL? {
        if let url = URL(
            string: self.viewModel.mealDetails!.thumbnailImageUrlString
        ) {
            return url
        }
        
        return nil
    }
    
    // this will only be used when there is a detail
    private var mealDetail: MealDetail {
        self.viewModel.mealDetails!
    }
    
    var body: some View {
        ContentView
            .onAppear {
                self.viewModel.loadMealDetail(for: self.mealId)
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
    }
    
    @ViewBuilder
    private var ContentView: some View {
        if viewModel.mealDetails != nil {
            MealDetailView()
        }
        else {
            Text("Unfortunatly, Something went wrong! Please Try agin.")
                .font(.title)
                .bold()
                .foregroundColor(.orange)
                .padding()
                .frame(minHeight: .zero, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    private func MealDetailView() -> some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                }
                .frame(minWidth: .zero, maxWidth: .infinity, idealHeight: 600)
                .aspectRatio(contentMode: .fill)
                .overlay(
                    Color.black.opacity(0.35)
                )
                .cornerRadius(20)
                
                Text(self.mealDetail.name)
                    .font(.title2)
                    .bold()
                
                Divider()
                    .frame(minHeight: 2)
                    .overlay(Color.orange)
                
                MealSources
                
                MealPrepView
            }
        }
    }
    
    @ViewBuilder
    private var MealSources: some View {
        HStack(spacing: 25) {
            if self.mealDetail.hasYouTubeUrl {
                Link(destination: URL(string: self.mealDetail.youtubeUrlString!)!) {
                    Label("Watch recipe", systemImage: "play.circle.fill")
                        .font(.headline)
                }
            }
            
            if self.mealDetail.hasSourceUrl {
                Link(destination: URL(string: self.mealDetail.youtubeUrlString!)!) {
                    Label("Read more", systemImage: "link.circle.fill")
                        .font(.headline)
                }
            }
        }
        .padding(
            .vertical,
            (self.mealDetail.hasSourceUrl && self.mealDetail.hasYouTubeUrl) ? 10 : 0)
    }
    
    @ViewBuilder
    private var MealPrepView: some View {
        Group {
            
            Text("Ingredients")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(
                    .top,
                    (self.mealDetail.hasSourceUrl && self.mealDetail.hasYouTubeUrl) ? 0 : 10)
            
            ForEach(self.mealDetail.ingredients, id: \.name) { (ingredient: MealIngredient) in
                HStack {
                    Text(ingredient.name)
                    
                    Spacer()
                    Divider()
                        .frame(minWidth: 3)
                        .overlay(Color.orange)
                    
                    Text(ingredient.measure)
                }
                .padding()
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(10)
            }

            Text("Instructions")
                .font(.headline)
                .fontWeight(.semibold)

            Text(self.mealDetail.instructions)
                .font(.callout)
                .padding()
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(10)
        }
    }
}

struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView(mealId: "52997")
    }
}
