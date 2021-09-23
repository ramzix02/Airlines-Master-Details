//
//  ApiHandler.swift
//   Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation
import Alamofire
import PromiseKit

protocol ApiHandlerProtocol {
    func fetchData<T: Decodable>(request: Requestable, mappingClass: T.Type) -> Promise<T>
}

class ApiHandler: ApiHandlerProtocol {
    func fetchData<T: Decodable>(request: Requestable, mappingClass: T.Type) -> Promise<T> {
        return Promise<T> { seal in
            if NetworkMonitor.shared.netOn {
                Alamofire.request(request.path,
                           method: request.method,
                           parameters: request.parameters,
                           encoding: request.encoding,
                           headers: request.headers)
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            guard let jsonResponse = response.data else {
                                seal.reject(ErrorHandler.generalError)
                                return
                            }
                            do {

                                if let JSONString = String(data: jsonResponse, encoding: String.Encoding.utf8) {
                                   print("Response is: \(JSONString)")
                                }
                                
                                let search = try JSONDecoder().decode(T.self, from: jsonResponse)
                                seal.fulfill(search)
                            } catch (let error){
                                debugPrint("Error in decoding ** \n \(error.localizedDescription.description)")
                                seal.reject(ErrorHandler.generalError)
                            }
                        case .failure(let error):
                            debugPrint(error.localizedDescription.description)
                            seal.reject(error)
                        }
                    }
            } else {
                seal.reject(ErrorHandler.noInternetConnection)
            }
        }
    }
}
