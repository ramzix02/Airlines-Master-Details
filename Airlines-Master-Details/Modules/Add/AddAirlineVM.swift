//
//  AddAirlineVM.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 23/09/2021.
//

import Foundation

class AddAirlineVM: BaseViewModel {
    
    var name: String?
    var slogan: String?
    var country: String?
    var headQuarters: String?
    
    func addAirline() {
        startRequest(request: NetworkingApi.postNewAirline(dic: [
            "name": self.name ?? "",
            "slogan": self.slogan ?? "",
            "country": self.country ?? "",
            "head_quaters": self.headQuarters ?? "",
            "id": getRandomID()
        ]),
                     mappingClass: AddAirlineModel.self) { _ in
        }
    }
    
}

//MARK: - Validate Inputs.
extension AddAirlineVM{
    
    func validateEntryField(text: String) -> Bool{
        text.isEmpty ? false : true
    }
    
    func validateEntries() -> Bool {
        guard let name = self.name else {
          return false
        }
         guard let slogan = self.slogan else {
          return false
        }
        guard let country = self.country else {
          return false
        }
        guard let headQuarters = self.headQuarters else {
          return false
        }
        let nameValid = self.isValidInput(Input: name)
        let sloganValid = self.isValidInput(Input: slogan)
        let countryValid = self.isValidInput(Input: country)
        let headQuartersValid = self.isValidInput(Input: headQuarters)

        return nameValid && sloganValid && countryValid && headQuartersValid
    }
    
    private func isValidInput(Input: String) -> Bool{
        Input.isEmpty ? false : true
    }
}

//MARK: - Make ID for the request.
extension AddAirlineVM{
    private func getRandomID() -> String {
        let date = Date()
        let timeInterval = date.timeIntervalSince1970
        let intTimeInterval = Int(timeInterval)
        let uniqueID = String(intTimeInterval)
        return uniqueID
    }
}
