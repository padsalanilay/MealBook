//
//  MealCategoryView.swift
//  Meal Book
//
//  Created by Nilay Padsala on 3/9/23.
//

import SwiftUI

struct MealCategoryView: View {
    @State var category: MealCategory
    @Binding var selectedCategoryID: String
        
    var categoryURL: URL? {
        if let url = URL(string: self.category.thumbNailImage) {
            return url
        }
        
        return nil
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: categoryURL) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "photo")
            }
                .frame(width: 50, height: 50)
                .cornerRadius(25)
            
            Text(category.name)
                .font(.callout)
                .foregroundColor(
                    self.category.id == self.selectedCategoryID ? .orange : .primary
                )
                .fontWeight(.bold)
        }
        .background(
            (self.category.id == self.selectedCategoryID ? Color.orange : Color.secondary)
                .blur(radius: 80)
        )
        .padding()
        .cornerRadius(10)
    }
}

struct MealCategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MealCategoryView(
                category: MealCategory(
                    id: "3",
                    name: "Dessert",
                    thumbNailImage: "https://www.themealdb.com/images/category/dessert.png",
                    description: "Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal.\r\n\r\nThe term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts."
                ), selectedCategoryID: .constant("3")
            )
            
            MealCategoryView(
                category: MealCategory(
                    id: "3",
                    name: "Dessert",
                    thumbNailImage: "",
                    description: "Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal.\r\n\r\nThe term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts."
                ), selectedCategoryID: .constant("1")
            )
        }
        .previewLayout(.sizeThatFits)
    }
}
