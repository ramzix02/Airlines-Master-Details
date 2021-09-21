//
//  File.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import Foundation
import UIKit

extension UIView{
    
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
    
}
