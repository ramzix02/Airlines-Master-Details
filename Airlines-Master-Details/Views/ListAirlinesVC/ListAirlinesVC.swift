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
        

     //   RealmHelper.shared.delete()
        
       // var array: [AirlineModel] = [AirlineModel]()
        
        
        
//        let object0 = ListAirlinesModel()
//        object0.nam = "Awad"
//        object0.id = 7
//        array.append(object0)
//        
//        let object1 = ListAirlinesModel()
//        object1.name = "Awad"
//        object1.id = 8
//        array.append(object1)
//        
//        let object2 = ListAirlinesModel()
//        object2.name = "Asd"
//        object2.id = 88
//        array.append(object2)
//
//        //let array = [object0, object1, object2]
//
//        RealmHelper.shared.save(arrListAirlines: array)
        
        
        
        
            //   RealmHelper.shared.render()
    }
    
    /*class AirlineModel : Object{
     @objc dynamic var id: Double = 0.0
     @objc dynamic var name: String = ""
     @objc dynamic var country: String = ""
     @objc dynamic var logo: String = ""
     @objc dynamic var slogan: String = ""
     @objc dynamic var headQuaters: String = ""
     @objc dynamic var website: String = ""
     @objc dynamic var established: String = ""
     @objc dynamic var createdDate: String = ""
     
     override static func primaryKey() -> String? {
         return "id"
         }
 }*/
    

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
                    print("Empty")
                    
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
    
    @IBAction func filterBtnAction(_ sender: Any) {
        self.viewModel.searchInArray(filterText: searchTF.text ?? "")
        searchTF.resignFirstResponder()
    }
    
}

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


extension ListAirlinesVC: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewModel.searchInArray(filterText: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTF.resignFirstResponder()
        return true
    }
}

