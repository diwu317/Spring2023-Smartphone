//
//  TableViewCell.swift
//  InstaWithoutDBAndCloud
//
//  Created by Di Wu on 4/22/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageContainer: UIImageView!
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var lblLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
