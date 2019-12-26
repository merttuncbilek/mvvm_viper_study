//
//  BasePresenterProtocol.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

protocol BaseViewProtocol {
    func showProgress()
    func dismissProgress()
    func showMessage(_ message: String)
}

class BaseView: BaseViewProtocol {
    
    func showProgress() {
        
    }
    
    func dismissProgress() {
        
    }
    
    func showMessage(_ message: String) {
        
    }
    
}
