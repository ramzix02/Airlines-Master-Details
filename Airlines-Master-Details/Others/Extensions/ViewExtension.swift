//
//  File.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import Foundation
import UIKit

extension UIView{
    
    func roundCorners(cornerRadius: Double, Corners:UIRectCorner) {
          let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: Corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          maskLayer.path = path.cgPath
          self.layer.mask = maskLayer
      }
    
    func addBottomShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.4
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    func addRoundedRadiusWithShadow(raduis: CGFloat){
        self.layer.cornerRadius = raduis
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
    }
    
    func setCircularWithShadow() {
            self.layer.cornerRadius = self.frame.width / 2
            self.layer.shadowColor = UIColor.darkGray.cgColor
            self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
            self.layer.shadowRadius = 1.0
            self.layer.shadowOpacity = 0.4
            self.layer.masksToBounds = false
        }
    
    func addBorderAndRounded(){
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.layer.cornerRadius = 6
    }
    
    static var imageView = UIImageView()
    static var indicator = UIActivityIndicatorView()
    static var LoadingView = UIView()
    
    func showIndicator(){
         let Gif = UIImage.gif(name: "Loading")
          UIView.LoadingView.frame = UIScreen.main.bounds
          UIView.self.LoadingView.backgroundColor = UIColor.black
          UIView.self.LoadingView.isUserInteractionEnabled = false
          UIView.self.LoadingView.alpha = 0.5
          UIView.indicator.isUserInteractionEnabled = false
       
          UIView.imageView.frame = CGRect(x: (UIView.self.LoadingView.frame.size.width / 2), y: (UIView.self.LoadingView.frame.size.height / 2), width: 70, height: 70)
          
          UIView.imageView.center =  UIView.self.LoadingView.center
          UIView.imageView.contentMode = .scaleAspectFit
        
          DispatchQueue.main.async( execute: {
              UIView.imageView.image = Gif
              UIApplication.shared.keyWindow?.addSubview(UIView.self.LoadingView)
              UIApplication.shared.keyWindow?.addSubview(UIView.self.imageView)
              UIApplication.shared.beginIgnoringInteractionEvents()
          })
      }
      func hideIndicator(){

          DispatchQueue.main.async( execute:
              {
                  UIView.self.imageView.removeFromSuperview()
                  UIView.self.LoadingView.removeFromSuperview()
                  UIApplication.shared.endIgnoringInteractionEvents()
          })
      }
    
}
