//
//  ListAirlinesModel.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation

// MARK: - ListAirlinesModelElement
struct ListAirlinesModelElement: Codable {
    var id: Double?
    var name: String?
    var country: String?
    var logo: String?
    var slogan, headQuaters: String?
    var website: String?
    var established, createdDate: String?

    enum CodingKeys: String, CodingKey {
        case id, name, country, logo, slogan
        case headQuaters = "head_quaters"
        case website, established, createdDate
    }
}

typealias ListAirlinesModel = [ListAirlinesModelElement]

