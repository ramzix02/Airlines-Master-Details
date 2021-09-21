//
//  AddNewAirlineVC.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import UIKit

class AddNewAirlineVC: UIViewController {

    @IBOutlet var nameTF: UITextField!
    @IBOutlet var sloganTF: UITextField!
    @IBOutlet var countryTF: UITextField!
    @IBOutlet var headquartersTF: UITextField!
    @IBOutlet var cancelTF: UITextField!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    @IBOutlet var popupView: UIView!
    @IBOutlet var blurView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        popupView.roundCorners(cornerRadius: 20, Corners: [.topLeft,.topRight])
    }
    
    func setupViews(){
        
        confirmBtn.layer.cornerRadius = 6
        cancelBtn.addBorderAndRounded()
    
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(blurEffectView)
        
    }
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        
        //Validation in VM
        validateTF(textField: nameTF)
        validateTF(textField: sloganTF)
        validateTF(textField: countryTF)
        validateTF(textField: headquartersTF)
        validateTF(textField: cancelTF)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension AddNewAirlineVC{
    func validateTF(textField: UITextField) {
        if textField.text?.count == 0{
            (textField.layer.borderColor = #colorLiteral(red: 0.9019607843, green: 0, blue: 0, alpha: 1))
        }else{
            (textField.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
        }
    }
}
