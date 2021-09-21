//
//  AirlineDetailsVC.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import UIKit

class AirlineDetailsVC: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var detailsView: UIView!
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var countryLbl: UILabel!
    @IBOutlet var sloganLbl: UILabel!
    @IBOutlet var headquartersLbl: UILabel!
    
    @IBOutlet var visitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        topView.addBottomShadow()
        visitBtn.addRoundedRadiusWithShadow(raduis: 6)
    }

    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func visitBtnAction(_ sender: Any) {
        if let url = URL(string: "https://www.qatarairways.com") {
            UIApplication.shared.open(url)
        }
    }
}
