//
//  BasePresenter.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 19.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

protocol BasePresenterProtocol {
    func onErrorReceived(message: String)
}

class BasePresenter: BasePresenterProtocol {
    func onErrorReceived(message: String) {
        fatalError("This method must be overriden.")
    }
}
