//
//  ListAirlinesVM.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//



import Foundation


class ListAirlinesVM: BaseViewModel{
    
    
    private var arrListAirlines = [ListAirlinesModelElement]()
    private var filterArrListAirlines = [ListAirlinesModelElement]()
    var isFiltered: Bool = false

    func getListAirlinesAPI() {
        startRequest(request: NetworkingApi.getAirlines,
                     mappingClass: ListAirlinesModel.self) {[weak self] response in
            self?.arrListAirlines.append(contentsOf: response ?? [])
        }
    }
    
    func getarrAirlines() -> [ListAirlinesModelElement] {
        isFiltered ? filterArrListAirlines : arrListAirlines
    }
    
    func searchInArray(filterText: String) {
        filterArrListAirlines = [ListAirlinesModelElement]()
        state = .loading
        
        if (filterText.isEmpty){
            isFiltered = false
        }else{
            isFiltered = true
            filterArrListAirlines = arrListAirlines.filter {$0.name?.contains(filterText) ?? false}
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
