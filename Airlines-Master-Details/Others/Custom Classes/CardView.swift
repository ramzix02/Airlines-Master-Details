//
//  CardView.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import Foundation
import UIKit

//MARK: - CardView with rounded corners and shadow.
@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    @IBInspectable var shadowOffsetWidth: Double = 0
    @IBInspectable var shadowOffsetHeight: Double = 0.1
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.1
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.borderColor = uicolorFromHex(0x5c5c5c).cgColor
        layer.borderWidth = 0.1
    }
    
    func uicolorFromHex(_ rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    @IBInspectable
       var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }
    
    @IBInspectable
       var borderColor: UIColor? {
           get {
               if let color = layer.borderColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               if let color = newValue {
                   layer.borderColor = color.cgColor
               } else {
                   layer.borderColor = nil
               }
           }
       }
}
