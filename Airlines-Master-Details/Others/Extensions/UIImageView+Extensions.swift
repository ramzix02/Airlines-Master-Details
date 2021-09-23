//
//  UIImageView+Extensions.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation

import UIKit
import ImageIO

//MARK: - Load GIF Images.
extension UIImageView {
    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}
