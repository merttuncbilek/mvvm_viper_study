//
//  Binding.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 2.01.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class Bond<T> {
    typealias Listener = (T) -> Void
    var listener: Listener
    
    init(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    func bind(observable: Observable<T>) {
        observable.bond = self
    }
}
