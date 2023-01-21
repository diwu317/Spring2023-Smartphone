//
//  ViewController.swift
//  Hello World
//
//  Created by Di Wu on 1/20/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pressMeAction(_ sender: UIButton) {
        print("Hello World!")
        label.text = "Hello World!"
    }
    

}

