//
//  MealsModel.swift
//  Recipe Rolodex
//
//  Created by Charlene Johnson on 11/9/21.
//

import Foundation

struct MealsModel: Decodable {
    var meals: [Meals] = []
}

struct Meals: Decodable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}
