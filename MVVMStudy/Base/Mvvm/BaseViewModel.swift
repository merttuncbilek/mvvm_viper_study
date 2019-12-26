//
//  BaseViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

protocol BaseViewModelProtocol: class {
    var error: Observable<String> {get set}
    var navigationEvent: Observable<NavigationEvent> {get set}
    
    associatedtype Model
    var model: Model {get set}

    init()
}

class BaseViewModel<M>: BaseViewModelProtocol where M: BaseModelProtocol {
    
    var model: M
    
    required init() {
        self.model = M()
        
        self.setUpObserves()
        
        self.model.observableError.observe = { error in
            self.error.value = error
        }
    }
    
    var error = Observable<String>()
    var navigationEvent = Observable<NavigationEvent>()
    
    func setUpObserves() {
        fatalError("This function must be implemented")
    }
    
}
