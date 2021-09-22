//
//  AddAirlineVM.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 23/09/2021.
//

import Foundation

class AddAirlineVM: BaseViewModel {
    
    
    func addAirline() {
        startRequest(request: NetworkingApi.postNewAirline(dic: [
            "name":"111",
            "slogan":"222",
            "country":"333",
            "head_quaters":"444"
        ]),
                     mappingClass: AddAirlineModel.self) {[weak self] response in
            //self?.arrListAirlines.append(contentsOf: response ?? [])
            
            print("hhhhhh: \(response)")
            
            //Add to databse
            //name and id
            //redundent data --> primary key
            
        }
    }

    
}
