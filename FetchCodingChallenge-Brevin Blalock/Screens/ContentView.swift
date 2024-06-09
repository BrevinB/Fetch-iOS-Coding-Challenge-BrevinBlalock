//
//  ContentView.swift
//  FetchCodingChallenge-Brevin Blalock
//
//  Created by Brevin Blalock on 6/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mealViewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mealViewModel.meals, id: \.self) { item in
                    NavigationLink { MealDetailView(mealID: item.idMeal) } label: {
                        HStack {
                            AsyncImage(url: URL(string: item.strMealThumb)) { image in
                                image.image?
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            .padding(.trailing, 20)
                            
                            Text(item.strMeal)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Desserts")
            .frame( maxWidth: .infinity)
            .listStyle(.plain)
        }
        .onAppear() {
            mealViewModel.fetchMeals()
        }
    }
}

#Preview {
    ContentView()
}
