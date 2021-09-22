//
//  UIViewController+Extensions.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation
import UIKit

extension UIViewController{
    func showErrorAlert(title: String, errorMessage: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default)
        alert.addAction(action)
        return alert
    }
    
    func showErrorMsg(msg: String) {
             DispatchQueue.main.async { [weak self] in
             guard let self = self else{return}
                let alert = self.showErrorAlert(title: "Ooops!", errorMessage: msg)
             self.present(alert, animated: true, completion: nil)
        }
    }
}
