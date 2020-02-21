//
//  SafeUnwrap.swift
//  MVVMStudy
//
//  Created by Mert Tuncbilek on 21.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation

postfix operator ~

postfix func ~(_ val: Int? ) -> Int {
    return safeUnwrap(val)
}

private func safeUnwrap(_ integer: Int?, default: Int = 0) -> Int {
    return integer ?? `default`
}

postfix func ~<T>(_ val: [T]?) -> [T] {
    return safeUnwrap(val)
}

private func safeUnwrap<T>(_ array: [T]?, default: [T] = [T]()) -> [T] {
    return array ?? `default`
}
