//
//  CategoryModel.swift
//  Recipe Rolodex
//
//  Created by Charlene Johnson on 11/9/21.
//

import Foundation

struct CategoryModel: Decodable {
    var categories: [Categories] = []
}

struct Categories: Decodable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}
