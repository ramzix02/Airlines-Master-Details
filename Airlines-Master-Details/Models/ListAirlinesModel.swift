//
//  ListAirlinesModel.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation

// MARK: - ListAirlinesModelElement
struct ListAirlinesModelElement: Codable {
    let id: Double?
    let name: String?
    let country: String?
    let logo: String?
    let slogan, headQuaters: String?
    let website: String?
    let established, createdDate: String?

    enum CodingKeys: String, CodingKey {
        case id, name, country, logo, slogan
        case headQuaters = "head_quaters"
        case website, established, createdDate
    }
}

typealias ListAirlinesModel = [ListAirlinesModelElement]
