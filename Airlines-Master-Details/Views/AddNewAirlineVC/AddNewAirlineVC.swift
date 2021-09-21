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
        
        nameTF.addRoundedRadiusWithShadow(raduis: 6)
        sloganTF.addRoundedRadiusWithShadow(raduis: 6)
        countryTF.addRoundedRadiusWithShadow(raduis: 6)
        headquartersTF.addRoundedRadiusWithShadow(raduis: 6)
        cancelTF.addRoundedRadiusWithShadow(raduis: 6)
        confirmBtn.addRoundedRadiusWithShadow(raduis: 6)
        cancelBtn.addRoundedRadiusWithShadow(raduis: 6)
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(blurEffectView)
        
    }
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
