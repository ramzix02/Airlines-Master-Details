//
//  NetworkingApi.swift
//   Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation
import Alamofire

enum NetworkingApi {
    case getSearchPhotos(page: Int)
    case getSizes(photoId: String)
    case getAirlines
    case getAirlineDetails(id: String)
}

extension NetworkingApi: Requestable {
    
    var path: String {

        switch self {
        case .getAirlineDetails(let id):
            return "\(APIInfo.url)/\(id)"
        default:
            return APIInfo.url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getSearchPhotos(let page):
            return APIInfo.getSearchParams(page: page)
        case .getSizes(let photoId):
            return APIInfo.getSizesParams(photoId: photoId)
        case .getAirlineDetails(let id):
            return APIInfo.getAirlineDetailsParams(id: id)
        default:
            return [:]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return HTTPHeaders(uniqueKeysWithValues: [])
        }
    }
    
    
}
