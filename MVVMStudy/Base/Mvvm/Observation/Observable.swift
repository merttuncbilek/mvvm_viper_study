//
//  Observable.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 23.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class Observable<T> {
    
    var value: T! {
        didSet {
            DispatchQueue.main.async {
                self.bond?.listener(self.value)
                self.observe?(self.value)
            }
        }
    }
    
    weak var bond: Bond<T>?
    
    var observe: ((T) -> Void)?
}
