//
//  APIInfo.swift
//   Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation

struct APIInfo {
    
    static let url = "https://api.instantwebtools.net/v1/airlines"
    
    static func getAirlineDetailsParams(id: String) -> [String: String] {
        return ["id": id]
    }
    
    static func postNewAirlineParams(dic: [String: String]) -> [String: String] {
        return dic
    }
}
