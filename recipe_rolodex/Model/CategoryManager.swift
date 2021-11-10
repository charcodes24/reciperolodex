//
//  CategoryManager.swift
//  Recipe Rolodex
//
//  Created by Charlene Johnson on 11/9/21.
//

import UIKit

struct CategoryManager {
    
    func fetchCategories(completion: @escaping(CategoryModel) -> Void) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")
        else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print ("Error fetching categories: \(error.localizedDescription)")
            }
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(CategoryModel.self, from: jsonData)
                print(decodedData.categories[0])
                completion(decodedData)
            } catch {
                print("Error decoding data.")
            }
        }
        dataTask.resume()
    }
}

