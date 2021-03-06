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
    var isLoadFirstTime: Bool = true

    func getListAirlinesAPI() {
        
        if NetworkMonitor.shared.netOn {
        startRequest(request: NetworkingApi.getAirlines,
                     mappingClass: ListAirlinesModel.self) {[weak self] response in
            self?.arrListAirlines.append(contentsOf: response ?? [])
            
            //update your cache if their are new data.
            if self?.isLoadFirstTime ?? true{
                if let arrListAirlines = self?.arrListAirlines{
                  CoreDataHelper.shared.insertAllAirlines(arrAirlines: arrListAirlines)
                }
                self?.isLoadFirstTime = false
            }
            
        }
            
        }else{
            state = .loading
            self.arrListAirlines = CoreDataHelper.shared.retriveAllAirlines()
            state = .populated
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
                return airline.name?.lowercased().contains(filterText.lowercased()) ?? false || airline.country?.lowercased().contains(filterText.lowercased()) ?? false ||
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
