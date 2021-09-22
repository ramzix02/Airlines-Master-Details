//
//  AirlineDetails.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation

// MARK: - AirlineDetailsModel
struct AirlineDetailsModel: Codable {
    let id: Int?
    let name, country: String?
    let logo: String?
    let slogan, headQuaters, website, established: String?

    enum CodingKeys: String, CodingKey {
        case id, name, country, logo, slogan
        case headQuaters = "head_quaters"
        case website, established
    }
}
