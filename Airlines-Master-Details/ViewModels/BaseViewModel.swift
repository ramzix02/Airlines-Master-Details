//
//  BaseViewModel.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation

class BaseViewModel: NSObject {
    
    private let api = ApiHandler()
    
    var updateLoadingStatus: (()->())?
    var updateError: ((String)->())?
    var checkInternetConnection: (() -> ())?
    
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
    func startRequest<M: Codable>(request: Requestable, mappingClass: M.Type,successCompletion: @escaping((M?) -> Void), showLoading: Bool = true) {
    
        if showLoading {
            state = .loading
        }
        
        api.fetchData(request: request, mappingClass: mappingClass).done{[weak self] success in
            self?.state = .populated
            successCompletion(success)
        }.catch {[weak self] error in
            self?.state = .error
            self?.updateError?((error as? ErrorHandler)?.rawValue ?? error.localizedDescription.description)
        }
    }
}
