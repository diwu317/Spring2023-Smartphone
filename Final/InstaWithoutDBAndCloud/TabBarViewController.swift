//
//  TabBarViewController.swift
//  InstaWithoutDBAndCloud
//
//  Created by Di Wu on 4/22/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = viewControllers?[0] as! HomeViewController
        let uploadPicVC = viewControllers?[1] as! UploadImageViewController
        
        uploadPicVC.uploadProtocol = homeViewController.self
    }
    


}
