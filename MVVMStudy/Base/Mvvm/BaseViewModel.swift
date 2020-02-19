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
    
    init()
}

class BaseViewModel: BaseViewModelProtocol {
    
    required init() {
        self.setUpObserves()
    }
    
    var error = Observable<String>()
    var navigationEvent = Observable<NavigationEvent>()
    
    func setUpObserves() {
        fatalError("This function must be implemented")
    }
    
    func observeError(on models: BaseModelProtocol...) {
        for model in models {
            model.observableError <-> { [weak self] error in
                self?.error.value = error                
            }
        }
    }
    
}
