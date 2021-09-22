//
//  ListAirlinesVM.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//



import Foundation


class ListAirlinesVM: BaseViewModel{
    
    
    private var arrListAirlines = [ListAirlinesModelElement]()

    func getListAirlinesAPI() {
        startRequest(request: NetworkingApi.getAirlines,
                     mappingClass: ListAirlinesModel.self) {[weak self] response in
            self?.arrListAirlines.append(contentsOf: response ?? [])
        }
    }
    
    func getarrAirlines() -> [ListAirlinesModelElement] {
        return arrListAirlines
    }
    
}
