//
//  Helper.swift
//  Inspection
//
//  Created by Anpu S Anand on 09/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

class Helper {
static var kAppName = "Inspection"
    
static func showAlert(message: String) {
       let alert = UIAlertController(title: Helper.kAppName, message: message as String, preferredStyle: UIAlertController.Style.alert)
       
       
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
       
       UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
   }
}
