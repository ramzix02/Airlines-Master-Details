//
//  ListAirlinesVC.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import UIKit

class ListAirlinesVC: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var searchBtn: UIButton!
    
    @IBOutlet var listingView: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var floatingBtn: UIButton!
    
    lazy var viewModel: ListAirlinesVM = {
        return ListAirlinesVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
        setupTableView()
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
                    
                case .populated:
                    self.view.hideIndicator()
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        viewModel.getListAirlinesAPI()
    }
    
    

    func setupViews(){
        topView.addBottomShadow()
        searchBtn.addRoundedRadiusWithShadow(raduis: 6)
        floatingBtn.setCircularWithShadow()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: ListAirlinesTVCell.self)
        tableView.backgroundColor = UIColor.clear
    }
    
    @IBAction func floatingBtnAction(_ sender: Any) {
        let vc = AddNewAirlineVC()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
}

extension ListAirlinesVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getarrAirlines().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ListAirlinesTVCell
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.lblTitle.text = viewModel.getarrAirlines()[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AirlineDetailsVC()
        vc.id = viewModel.getarrAirlines()[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

