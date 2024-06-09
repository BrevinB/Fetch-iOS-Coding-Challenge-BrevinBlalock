//
//  Meal.swift
//  FetchCodingChallenge-Brevin Blalock
//
//  Created by Brevin Blalock on 6/8/24.
//

import Foundation

struct Meal: Hashable, Codable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}

struct Meals: Hashable, Codable {
    var meals: [Meal]
}

struct MealDetail: Hashable, Codable {
    var meals: [MealDetails]
}
