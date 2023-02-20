//
//  ViewController.swift
//  TwoTables
//
//  Created by Di Wu on 2/19/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let resturants = ["KFC", "McDonald's", "Pizza Hut", "Urban Gyro"]
    let food = [[],["Fried Chicken", "Biscuits", "Coleslaw"], ["French Fries", "Big Mac", "Sausage Burrito"], ["The Edge Pizza", "Detroit", "Cheese Pizza"], ["Greek Fries", "Baklava", "Kebab"]]
    
    var selectedRestaurantIndex = 0
    var currentFood = [String]()

    @IBOutlet weak var tblViewTop: UITableView!
    
    @IBOutlet weak var tblViewBottom: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFood = food[selectedRestaurantIndex];
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewTop{
            return resturants.count
        }else{
            return currentFood.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewTop{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
            cell.textLabel?.text = resturants[indexPath.row];
            return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
            cell.textLabel?.text = currentFood[indexPath.row];
            return cell
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewTop{
            selectedRestaurantIndex = indexPath.row;
            currentFood = food[selectedRestaurantIndex + 1];
            tblViewBottom.reloadData();
        }
    }
}
    

