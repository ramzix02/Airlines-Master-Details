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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableView()

    }

    func setupViews(){
        topView.addBottomShadow()
        searchTF.addRoundedRadiusWithShadow(raduis: 6)
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
        print("Redirect to add new airline..")
    }
    
}

extension ListAirlinesVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ListAirlinesTVCell
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    
}

