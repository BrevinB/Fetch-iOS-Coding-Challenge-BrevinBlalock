//
//  ContentView.swift
//  FetchCodingChallenge-Brevin Blalock
//
//  Created by Brevin Blalock on 6/8/24.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealDetials: MealDetails = MealDetails(idMeal: "", strMeal: "", strInstructions: "")
    
    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let meals = try JSONDecoder().decode(Meals.self, from: data)
                DispatchQueue.main.async {
                    self?.meals = meals.meals
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func fetchMealDetails(mealID: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let mealDetails = try JSONDecoder().decode(MealDetail.self, from: data)
                DispatchQueue.main.async {
                    self?.mealDetials = mealDetails.meals.first ?? MealDetails(idMeal: "", strMeal: "", strInstructions: "")
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var mealViewModel = MealViewModel()
    let url: String = "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"
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
                            .frame(width: 80, height: 80)
                            .cornerRadius(20)
                            .padding(.trailing, 20)
                            
                            Text(item.strMeal)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.yellow)
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

struct MealDetailView: View {
    @StateObject var mealViewModel = MealViewModel()
    var mealID: String
    var ingredientProperties: [String?] {
        return [mealViewModel.mealDetials.strIngredient1,
                mealViewModel.mealDetials.strIngredient2,
                mealViewModel.mealDetials.strIngredient3,
                mealViewModel.mealDetials.strIngredient4,
                mealViewModel.mealDetials.strIngredient5,
                mealViewModel.mealDetials.strIngredient6,
                mealViewModel.mealDetials.strIngredient7,
                mealViewModel.mealDetials.strIngredient8,
                mealViewModel.mealDetials.strIngredient9,
                mealViewModel.mealDetials.strIngredient10,
                mealViewModel.mealDetials.strIngredient11,
                mealViewModel.mealDetials.strIngredient12,
                mealViewModel.mealDetials.strIngredient13,
                mealViewModel.mealDetials.strIngredient14,
                mealViewModel.mealDetials.strIngredient15,
                mealViewModel.mealDetials.strIngredient16,
                mealViewModel.mealDetials.strIngredient17,
                mealViewModel.mealDetials.strIngredient18,
                mealViewModel.mealDetials.strIngredient19,
                mealViewModel.mealDetials.strIngredient20
                ]
    }
    var measurementProperties: [String?] {
        return [mealViewModel.mealDetials.strMeasure1,
                mealViewModel.mealDetials.strMeasure2,
                mealViewModel.mealDetials.strMeasure3,
                mealViewModel.mealDetials.strMeasure4,
                mealViewModel.mealDetials.strMeasure5,
                mealViewModel.mealDetials.strMeasure6,
                mealViewModel.mealDetials.strMeasure7,
                mealViewModel.mealDetials.strMeasure8,
                mealViewModel.mealDetials.strMeasure9,
                mealViewModel.mealDetials.strMeasure10,
                mealViewModel.mealDetials.strMeasure11,
                mealViewModel.mealDetials.strMeasure12,
                mealViewModel.mealDetials.strMeasure13,
                mealViewModel.mealDetials.strMeasure14,
                mealViewModel.mealDetials.strMeasure15,
                mealViewModel.mealDetials.strMeasure16,
                mealViewModel.mealDetials.strMeasure17,
                mealViewModel.mealDetials.strMeasure18,
                mealViewModel.mealDetials.strMeasure19,
                mealViewModel.mealDetials.strMeasure20
                ]
    }
    
    var ingredients: [String] {
        return ingredientProperties.compactMap{ $0 }
    }
    
    var measurements: [String] {
        return measurementProperties.compactMap { $0 }
    }
    
    var body: some View {
        
        let filteredData1 = ingredients.filter { !$0.isEmpty }
        let filteredData2 = measurements.filter { !$0.isEmpty }

        VStack() {
            Text(mealViewModel.mealDetials.strMeal)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.yellow)
            
            
            ScrollView {
                TextEditor(text: .constant(mealViewModel.mealDetials.strInstructions))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: false)
                    .multilineTextAlignment(.leading)
                    .frame(height: 300)
                    .padding()
                    .lineSpacing(5)
                    
            }
            .frame(height: 200)
            
            VStack(alignment: .leading) {
                Text("Ingredients and Measurements:")
                    .padding(.bottom, 20)
               
                ForEach(Array(zip(filteredData1, filteredData2)), id: \.0) { val1, val2 in
                    HStack {
                        Text(val1)
                        //Spacer()
                        Text(":")
                        //Spacer()
                        Text(val2)
                    }
                    .padding(.vertical, 2)
                }
            }
            .padding()
        }
        .onAppear {
            mealViewModel.fetchMealDetails(mealID: mealID)
            
            print(ingredients.count)
            print(measurements.count)
        }
    }
}

#Preview {
    ContentView()
}
