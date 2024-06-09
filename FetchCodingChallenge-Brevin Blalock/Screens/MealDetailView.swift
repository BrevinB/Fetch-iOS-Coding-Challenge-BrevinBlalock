//
//  MealDetailView.swift
//  FetchCodingChallenge-Brevin Blalock
//
//  Created by Brevin Blalock on 6/9/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var mealViewModel = MealViewModel()
    
    var mealID: String
    
    var ingredients: [String] {
        let filteredIngredients = mealViewModel.ingredientProperties.compactMap { $0 }
        
        return filteredIngredients.filter { !$0.isEmpty }
    }
    
    var measurements: [String] {
        let filteredMeasurements = mealViewModel.measurementProperties.compactMap { $0 }
        return filteredMeasurements.filter { !$0.isEmpty }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text(mealViewModel.mealDetials.strMeal)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Instructions:")
                .padding(.leading, 15)
                .bold()
            
            ScrollView {
                Text(mealViewModel.mealDetials.strInstructions)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.secondary.opacity(0.3)))
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
            }
            
            Text("Ingredients and Measurements:")
                .padding(.leading, 15)
                .font(.headline)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(zip(ingredients, measurements)), id: \.0) { ingredient, measurement in
                        HStack {
                            Text(ingredient)
                                .bold()
                            Text(":")
                            Text(measurement)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 15)
        }
        .navigationBarTitle("", displayMode: .inline)
        .task {
            mealViewModel.fetchMealDetails(mealID: mealID)
        }
    }
}

#Preview {
    MealDetailView(mealID: "53049")
}
