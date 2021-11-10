//
//  MealsManager.swift
//  Recipe Rolodex
//
//  Created by Charlene Johnson on 11/9/21.
//

import UIKit
import Foundation

struct MealsManager {
    
    func fetchMealsByCategory(searchTerm: String, completion: @escaping(MealsModel) -> Void ) {
        
        
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(searchTerm)")
        else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print ("Error fetching meals: \(error.localizedDescription)")
            }
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(MealsModel.self, from: jsonData)
                print(decodedData.meals[0])
                completion(decodedData)
            } catch {
                print("Error decoding data.")
            }
        }
        dataTask.resume()
    }
}
