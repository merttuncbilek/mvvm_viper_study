//
//  Observable.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 23.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

typealias Observer<T> = (T) -> Void

class ObservableMine<T> {
    
    var value: T! {
        didSet {
            DispatchQueue.main.async {
                for observer in self.observers {
                    observer(self.value)
                }
            }
        }
    }
    
    var observers = [Observer<T>]()
}
