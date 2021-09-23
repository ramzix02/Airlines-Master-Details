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
    
//    func getListAirlinesAPI() {
//        startRequest(request: NetworkingApi.postNewAirline(dic: [
//            "name":"111",
//            "slogan":"222",
//            "country":"333",
//            "head_quaters":"444"
//        ]),
//                     mappingClass: AddAirlineModel.self) {[weak self] response in
//            //self?.arrListAirlines.append(contentsOf: response ?? [])
//
//            print("hhhhhh: \(response)")
//
//            //Add to databse
//            //name and id
//            //redundent data --> primary key
//
//        }
//    }

    
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
                return airline.name?.lowercased().contains(filterText) ?? false || airline.country?.lowercased().contains(filterText) ?? false ||
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
