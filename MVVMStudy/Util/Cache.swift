//
//  Cache.swift
//  MVVMStudy
//
//  Created by Mert Tuncbilek on 19.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation

struct Container<Value> {
    var value: Value
    var date: Date
}

class Cache<Key: Hashable, Value> {
    private var values = [Key: Container<Value>]()
    
    func insert(_ key: Key, value: Value) {
        let expireDate = Date().addingTimeInterval(1000)
        
        values[key] = Container(value: value, date: expireDate)
    }
    
    func get(_ key: Key) -> Value? {
        guard let container = values[key] else {
            return nil
        }
        
        if container.date > Date() {
            values[key] = nil
            return nil
        }
        
        return container.value
    }
    
}
