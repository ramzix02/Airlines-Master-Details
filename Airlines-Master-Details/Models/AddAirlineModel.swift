//
//  AddAirlineModel.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 23/09/2021.
//

import Foundation

// MARK: - AddModel
struct AddAirlineModel: Codable {
    let id, name, country, slogan: String?
    let headQuaters, website: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, country, slogan
        case headQuaters = "head_quaters"
        case website
        case v = "__v"
    }
}
