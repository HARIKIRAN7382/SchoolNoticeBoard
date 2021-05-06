//
//  StringExtesntion.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//

import Foundation
import  UIKit

extension String{
    // MARK:- Helpful For Converting Base 64 String to Image
    func base64Convert() -> UIImage?{
        // !!! Separation part is optional, depends on your Base64String !!!
        let temp = self.components(separatedBy: ",")
        let dataDecoded : Data = Data(base64Encoded: temp[0], options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage ?? UIImage()
    }
}
