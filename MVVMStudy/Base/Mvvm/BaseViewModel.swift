//
//  BaseViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

protocol BaseViewModelProtocol: class {
    var error: PassthroughSubject<String, Never> {get set}
    var navigationEvent: PassthroughSubject<NavigationEvent, Never> {get set}
    var state: PassthroughSubject<ViewState, Never> {get set}
    
    init()
}

class BaseViewModel: BaseViewModelProtocol {
    
    var bag = DisposeBag()
    
    required init() {
        self.setUpObserves()
    }
    
    var error = PassthroughSubject<String, Never>()
    var navigationEvent = PassthroughSubject<NavigationEvent, Never>()
    var state = PassthroughSubject<ViewState, Never>()
    
    func setUpObserves() {
        fatalError("This function must be implemented")
    }
    
    func observeError(on models: BaseModelProtocol...) {
        for model in models {
            model.observableError.observeNext { [weak self] error in
                self?.error.send(error)
                
            }.dispose(in: bag)
        }
    }
    
    func disposeBag() {
        bag.dispose()
    }
    
}
