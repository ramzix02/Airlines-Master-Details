//
//  ListAirlinesVC.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 21/09/2021.
//

import UIKit

let RefreshNotificationCtr = NotificationCenter.default
let RefreshBroadcast = "RefreshBroadcast"

class ListAirlinesVC: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTF: UITextField!{didSet{searchTF.delegate = self}}
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
        setupObservers()
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
                    self.tableView.reloadData()
                    
                case .populated:
                    self.view.hideIndicator()
                    self.tableView.reloadData()
                    
                }
            }
        }
        viewModel.getListAirlinesAPI()
    }
    
    @IBAction func floatingBtnAction(_ sender: Any) {
        let vc = AddNewAirlineVC()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        self.viewModel.searchInArray(filterText: searchTF.text ?? "")
        searchTF.resignFirstResponder()
    }
    
    deinit {
        RefreshNotificationCtr.removeObserver(self)
    }
    
}

//MARK: - Setup views.
extension ListAirlinesVC{
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
}

//MARK: - TableView Delegates.
extension ListAirlinesVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if viewModel.getarrAirlines().count == 0 {
                self.tableView.setEmptyMessage("No data available!")
            } else {
                self.tableView.restore()
            }

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
        
        if let id = viewModel.getarrAirlines()[indexPath.row].id{
            vc.id = Double(id)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.showToast(message: "No ID found for this trip!", font: .systemFont(ofSize: 12.0))
        }
    }
}

//MARK: - TextField Delegates.
extension ListAirlinesVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewModel.searchInArray(filterText: textField.text ?? "")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTF.resignFirstResponder()
        return true
    }
}

//MARK: - Add observers.
extension ListAirlinesVC{
    
    func setupObservers(){
        RefreshNotificationCtr.addObserver(self, selector: #selector(self.refreshRequest), name: Notification.Name(rawValue: RefreshBroadcast), object: nil)
    }
    
    @objc func refreshRequest(notification: Notification){
        viewModel.getListAirlinesAPI()
    }
    
}
