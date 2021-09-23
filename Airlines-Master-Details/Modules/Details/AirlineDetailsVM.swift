//
//  AirlineDetailsVM.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation


class AirlineDetailsVM: BaseViewModel{
    
    
    private var airlineDetailsObj: AirlineDetailsModel?

    func getAirlineDetailsAPI(id: String) {
        startRequest(request: NetworkingApi.getAirlineDetails(id: id),
                     mappingClass: AirlineDetailsModel.self) {[weak self] response in
            self?.airlineDetailsObj = response
        }
    }
    
    func getAirlineDetails() -> AirlineDetailsModel? {
        return airlineDetailsObj
    }
    
    func getWebsiteStr() -> String{
        let urlString = airlineDetailsObj?.website ?? ""
        let validUrlString = urlString.hasPrefix("http") ? urlString : "http://\(urlString)"
        return validUrlString
    }
    
    
}
