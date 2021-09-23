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
    
    lazy var viewModel: AddAirlineVM = {
        return AddAirlineVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initVM()
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
                    
                case .empty, .error:
                    self.view.hideIndicator()
                    print("Empty")
                    
                case .populated:
                    self.view.hideIndicator()
                    self.dismiss(animated: true)
                    RefreshNotificationCtr.post(name: NSNotification.Name(rawValue: RefreshBroadcast), object: nil)
                    
                }
                
            }
            
        }
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
        
        self.viewModel.name = nameTF.text
        self.viewModel.slogan = sloganTF.text
        self.viewModel.country = countryTF.text
        self.viewModel.headQuarters = headquartersTF.text
        
        if self.viewModel.validateEntries(){
            //Valid
            self.viewModel.addAirline()
        }else{
            //Not Valid
            showToast(message: "Please fill all fields first!", font: .systemFont(ofSize: 12.0))
        }
        
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
