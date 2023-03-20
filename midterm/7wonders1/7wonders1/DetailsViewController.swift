//
//  DetailsViewController.swift
//  7wonders1
//
//  Created by Di Wu on 3/19/23.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var textWonder: UITextView!
    var wonderText = ""
    var selectRow = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        textWonder.text = wonderText
    }
    


}
