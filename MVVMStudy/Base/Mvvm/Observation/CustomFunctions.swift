//
//  CustomFunctions.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 9.01.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation

infix operator ->>

func ->> <T>(lhs: Observable<T>, rhs: @escaping Observer<T>) {
    lhs.observers.append(rhs)
}
