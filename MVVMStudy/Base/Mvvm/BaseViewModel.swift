//
//  BaseViewModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

protocol BaseViewModelProtocol {
    var error: Observable<String> {get set}
    var navigationEvent: Observable<NavigationEvent> {get set}
    
    init()
}

class BaseViewModel: BaseViewModelProtocol {
    
    var error = Observable<String>()
    var navigationEvent = Observable<NavigationEvent>()
    
    required init() {
        self.observeError()
    }
    
    func observeError() {
        
    }
}
