//
//  ViewController.swift
//  Recipe Rolodex
//
//  Created by Charlene Johnson on 11/9/21.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    //PROPERTIES
    
    let reuseIdentifier = "CategoryCell"
    
    var categories: [Categories]? {
        didSet {
            DispatchQueue.main.async {
                [self] in tableView.reloadData()
            }
        }
    }
    
    var meals: [Meals]? {
        didSet {
            DispatchQueue.main.async {
                [self] in
                tableView.reloadData()
            }
        }
    }

    //LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        
        configureTableView()
        
        let categoryManager = CategoryManager()
        
        categoryManager.fetchCategories { (categories) in
            DispatchQueue.main.async {
                [self] in
                
                self.categories = categories.categories.sorted(by: { $0.strCategory < $1.strCategory})
            }
        }
    }
    
    //HELPERS
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
    //SEARCH BAR
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Track input in search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("input \(searchText)")
    }
    
    //submit fetch request with searchTerm interpolated to end of URL
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchTerm \(String(describing: searchBar.text))")
        
        let mealsManager = MealsManager()
        
        mealsManager.fetchMealsByCategory(searchTerm: searchBar.text ?? "") { (meals) in DispatchQueue.main.async {
            
            self.meals = meals.meals.sorted(by: { $0.strMeal < $1.strMeal})
            
            
                print("MEALS \(meals)")
        }
            
            
    }


    }
}

//UITableViewDataSource & UITableViewDelegate Methods
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let category = categories?[indexPath.row]
        
        
        cell.textLabel?.text = category?.strCategory
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        //i'm able to print the cell atttributes, one being text= nameOfCategory
        print(cell ?? nil)
        
       }

    //WHAT MY NEXT STEPS WOULD HAVE BEEN
    //1. I was trying to access the cell attribute "text" on finger tap
    //2. I would have appended this text to the end of another fetch request to retrieve all meals in this category
    //3. I would have sorted the data in alphabetical order
    //4. Again, my data would have been displayed in a list and I would have implmented didSelectRowAt on fingertap to access an identifying attribute within the cell
    //5. Send final fetch request and appended mealID to the end of url
    //6. Display meal name, instructions and ingredients/measurements

}
