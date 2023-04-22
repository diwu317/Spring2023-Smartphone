//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Di Wu on 4/22/23.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UploadImgProtocol {

    @IBOutlet weak var tblView: UITableView!
    
    var imgs : [UIImage] = [UIImage]()
    var locations = [String]()
    var titles = [String]()
    
    var uploadImgVC : UIViewController?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = navigationController?.tabBarController
        uploadImgVC = navigationController?.tabBarController?.viewControllers?[0]
        print(uploadImgVC?.title)
        
        let initData = realm.objects(InstaImageCelldata.self)
        for data in initData {
            imgs.append(UIImage(data: data.Image!)!)
            locations.append(data.location)
            titles.append(data.title)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("ImgTableViewCell", owner: self)?.first as! ImgTableViewCell;
        cell.imgView.image = imgs[indexPath.row]
        cell.titleLbl.text = titles[indexPath.row]
        cell.locationLbl.text = locations[indexPath.row]
        
        // Add long press gesture recognizer to the cell
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(_:)))
        cell.addGestureRecognizer(longPressGesture)
        
        return cell;
    }
    
    // Handle long press on table view cell
    @objc func cellLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            if let cell = gestureRecognizer.view as? ImgTableViewCell, let indexPath = tblView.indexPath(for: cell) {
                let imageData = realm.objects(InstaImageCelldata.self).filter("title == %@ AND location == %@", titles[indexPath.row], locations[indexPath.row])
                try! realm.write {
                    realm.delete(imageData)
                }
                // Remove the corresponding data from arrays
                imgs.remove(at: indexPath.row)
                locations.remove(at: indexPath.row)
                titles.remove(at: indexPath.row)
                
                // Vibrate the phone
                let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
                impactGenerator.prepare()
                impactGenerator.impactOccurred()
                
                // Reload table view
                tblView.reloadData()
            }
        }
    }
    
    
    func uploadedImgDelegate(img: UIImage, location: String, imgTitle: String) {
        imgs.append(img)
        locations.append(location)
        titles.append(imgTitle)
        
        tblView.reloadData()
    }
}
