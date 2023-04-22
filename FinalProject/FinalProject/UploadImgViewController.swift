//
//  UploadImgViewController.swift
//  FinalProject
//
//  Created by Di Wu on 4/22/23.
//

import UIKit
import CoreLocation
import RealmSwift

class UploadImgViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgTitle: UITextField!
    @IBOutlet weak var location: UILabel!
    
    var uploadImgDelegate : UploadImgProtocol?
    let locationManager = CLLocationManager()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    
    @IBAction func takePicAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Take a picture", message: "Something", preferredStyle: .alert)
        // Get location
//        locationManager.requestLocation()
        // Call locationManager.requestLocation() asynchronously in the background
        DispatchQueue.global(qos: .userInitiated).async {
            self.locationManager.requestLocation()
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ action in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
            
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){ action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){ action in
            print("Cancel")
            
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            img.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let recent_location = locations.last else {return}
        getAddressFromLocation(location: recent_location)
    }
    
    func getAddressFromLocation(location : CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                print(error)
                return
            }
            var address = ""
            guard let place = placemarks?.first else {return}
            if place.name != nil {
                address += place.name! + ","
            }
            if place.locality != nil {
                address += place.locality! + ","
            }
            if place.subLocality != nil {
                address += place.subLocality! + ","
            }
            if place.country != nil {
                address += place.country! + ","
            }
            if place.postalCode != nil {
                address += place.postalCode! + ","
            }
            
            print(address)
            self.location.text = address
        }
    }
    
    
    @IBAction func uploadAction(_ sender: Any) {
        guard let image = img.image else {return}
        guard let loc = location.text else {return}
        guard let title = imgTitle.text else {return}
        
        let imageData: Data? = image.pngData()
        
        let imgData: InstaImageCelldata = InstaImageCelldata()
        imgData.title = title
        imgData.location = loc
        imgData.Image = imageData
        
        // Add to the Realm
        do {
            try realm.write {
                realm.add(imgData, update: .modified)
            }
        } catch let error as NSError {
            print("Unable to add values to the DB " + error.localizedDescription)
        }
        
        uploadImgDelegate?.uploadedImgDelegate(img: image, location: loc, imgTitle: title)
        guard let tabBarVC = self.tabBarController else {return}
        tabBarVC.selectedIndex = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
