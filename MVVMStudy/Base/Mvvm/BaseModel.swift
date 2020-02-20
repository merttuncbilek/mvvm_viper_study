//
//  BaseModel.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

protocol BaseModelProtocol {
    var observableError: PassthroughSubject<String, Never> {get set}
    
}

class BaseModel: BaseModelProtocol {
    var observableError = PassthroughSubject<String, Never>()
    
}
