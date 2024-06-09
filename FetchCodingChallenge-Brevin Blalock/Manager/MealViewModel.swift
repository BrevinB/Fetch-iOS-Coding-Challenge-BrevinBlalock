//
//  MealViewModel.swift
//  FetchCodingChallenge-Brevin Blalock
//
//  Created by Brevin Blalock on 6/9/24.
//

import Foundation

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealDetials: MealDetails = MealDetails(idMeal: "", strMeal: "", strInstructions: "")
    
    var ingredientProperties: [String?] {
        return [self.mealDetials.strIngredient1,
                self.mealDetials.strIngredient2,
                self.mealDetials.strIngredient3,
                self.mealDetials.strIngredient4,
                self.mealDetials.strIngredient5,
                self.mealDetials.strIngredient6,
                self.mealDetials.strIngredient7,
                self.mealDetials.strIngredient8,
                self.mealDetials.strIngredient9,
                self.mealDetials.strIngredient10,
                self.mealDetials.strIngredient11,
                self.mealDetials.strIngredient12,
                self.mealDetials.strIngredient13,
                self.mealDetials.strIngredient14,
                self.mealDetials.strIngredient15,
                self.mealDetials.strIngredient16,
                self.mealDetials.strIngredient17,
                self.mealDetials.strIngredient18,
                self.mealDetials.strIngredient19,
                self.mealDetials.strIngredient20
        ]
    }
    
    var measurementProperties: [String?] {
        return [self.mealDetials.strMeasure1,
                self.mealDetials.strMeasure2,
                self.mealDetials.strMeasure3,
                self.mealDetials.strMeasure4,
                self.mealDetials.strMeasure5,
                self.mealDetials.strMeasure6,
                self.mealDetials.strMeasure7,
                self.mealDetials.strMeasure8,
                self.mealDetials.strMeasure9,
                self.mealDetials.strMeasure10,
                self.mealDetials.strMeasure11,
                self.mealDetials.strMeasure12,
                self.mealDetials.strMeasure13,
                self.mealDetials.strMeasure14,
                self.mealDetials.strMeasure15,
                self.mealDetials.strMeasure16,
                self.mealDetials.strMeasure17,
                self.mealDetials.strMeasure18,
                self.mealDetials.strMeasure19,
                self.mealDetials.strMeasure20
        ]
    }
    
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
        
        meals = meals.sorted { $0.strMeal < $1.strMeal }
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
