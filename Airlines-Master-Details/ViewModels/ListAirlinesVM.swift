//
//  ListAirlinesVM.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//



import Foundation

class ListAirlinesVM: BaseViewModel {
    
    private var arrListAirlines = [ListAirlinesModelElement]()
    private var filterArrListAirlines = [ListAirlinesModelElement]()
    
    var isFiltered: Bool = false
    
    //check neton
    //if is on call api
    //if not on call database

    func getListAirlinesAPI() {
        startRequest(request: NetworkingApi.getAirlines,
                     mappingClass: ListAirlinesModel.self) {[weak self] response in
            self?.arrListAirlines.append(contentsOf: response ?? [])
            
            //Add to databse
            //name and id
            //redundent data --> primary key
            
        }
    }
    
    func getarrAirlines() -> [ListAirlinesModelElement] {
        isFiltered ? filterArrListAirlines : arrListAirlines
    }
    
}


//MARK: - Searching logic.
extension ListAirlinesVM{
    
    func searchInArray(filterText: String) {
        filterArrListAirlines = [ListAirlinesModelElement]()
        state = .loading
        
        if (filterText.isEmpty){
            isFiltered = false
        }else{
            isFiltered = true
            
            filterArrListAirlines = arrListAirlines.filter { airline in
                return airline.name?.contains(filterText) ?? false || airline.country?.contains(filterText) ?? false ||
                    "\(airline.id ?? -1 )" == filterText
            }
        }
        
        checkEmptyState(count: filterArrListAirlines.count)
    }
    
    private func checkEmptyState(count: Int){
        if count != 0{
            state = .populated
        }else{
            state = .empty
        }
    }
}
