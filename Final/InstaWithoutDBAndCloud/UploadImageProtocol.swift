//
//  ProtocolUploadImage.swift
//  InstaWithoutDBAndCloud
//
//  Created by Di Wu on 4/22/23.
//

import Foundation
import UIKit

protocol UploadImageProtocol {
    
    func uploadedImageDelegate(img : UIImage, locationImg : String, titleImg : String)
}
