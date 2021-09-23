//
//  AirlineDetailsVC.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import UIKit

class AirlineDetailsVC: UIViewController {
    
    var id: Double?
    var companyWebsite: String = ""

    @IBOutlet var topView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var detailsView: UIView!
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var countryLbl: UILabel!
    @IBOutlet var sloganLbl: UILabel!
    @IBOutlet var headquartersLbl: UILabel!
    
    @IBOutlet var visitBtn: UIButton!
    
    lazy var viewModel: AirlineDetailsVM = {
        return AirlineDetailsVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initVM()
    }
    
    func setupViews(){
        topView.addBottomShadow()
        visitBtn.addRoundedRadiusWithShadow(raduis: 6)
    }
    
    
    func initVM(){
        
        viewModel.updateError = { [weak self] error in
            
            self?.view.hideIndicator()
            DispatchQueue.main.async {
                self?.showErrorMsg(msg: error)
            }
        }
        
        viewModel.checkInternetConnection = {[weak self] in
            self?.showErrorMsg(msg: ErrorHandler.noInternetConnection.rawValue)
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .loading:
                    self.view.showIndicator()
                    self.detailsView.alpha = 0
                    
                case .empty, .error:
                    self.view.hideIndicator()
                    self.detailsView.alpha = 0
                    
                case .populated:
                    self.view.hideIndicator()
                    //Show Data
                    self.fillData(obj: self.viewModel.getAirlineDetails())
                    self.detailsView.alpha = 1
                }
                
            }
            
        }
        if let id = self.id{
            viewModel.getAirlineDetailsAPI(id: "\(id)")
        }
        
    }

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func visitBtnAction(_ sender: Any) {
        
        if let url = URL(string: self.viewModel.getWebsiteStr()) {
            UIApplication.shared.open(url)
        }
    }
    
    func fillData(obj: AirlineDetailsModel?) {
        self.nameLbl.text = obj?.name
        self.countryLbl.text = obj?.country
        self.sloganLbl.text = obj?.slogan
        self.headquartersLbl.text = obj?.headQuaters
        self.companyWebsite = obj?.website ?? ""
    }
}
