//
//  ProtocolUploadImg.swift
//  FinalProject
//
//  Created by Di Wu on 4/22/23.
//

import Foundation
import UIKit

protocol UploadImgProtocol {
    func uploadedImgDelegate(img : UIImage, location : String, imgTitle : String)
}
