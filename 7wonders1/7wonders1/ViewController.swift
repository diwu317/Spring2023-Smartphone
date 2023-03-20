//
//  ViewController.swift
//  7wonders1
//
//  Created by Di Wu on 3/19/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let arr = ["The Colosseum, Rome, Italy", "The Great Wall of China", "The Taj Mahal, India", "Christ the Redeemer, Brazil", "Machu Picchu, Peru", "Chichén Itzá, Mexico", "Petra, Jordan"]
        
        let arrText = ["The Colosseum, Rome, Italy", "The Great Wall of China", "The Taj Mahal, India", "Christ the Redeemer, Brazil", "Machu Picchu, Peru", "Chichén Itzá, Mexico", "Petra, Jordan"]
        
        
        @IBOutlet weak var tblView: UITableView!
        
        var row = 0;
        let imgname = "wonder"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell =  Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TabelViewCell
            
            cell.imageContainer.image = UIImage(named: "wonder\(indexPath.row)")
            cell.lblimage.text = arr[indexPath.row]
            
            return cell
        }
        

        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            row = indexPath.row
            performSegue(withIdentifier: "segueDetails", sender: self)

        }
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueDetails"{
                let secondVC = segue.destination as! DetailsViewController
                let text = arrText[row]

                secondVC.wonderText = text

            }
        }

}

