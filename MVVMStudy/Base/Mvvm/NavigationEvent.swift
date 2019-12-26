//
//  NavigationEvent.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 25.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation

enum TargetScreen: String {
    case ProductDetail = "SegueOpenProductDetail"
}

class NavigationEvent {
    let target: TargetScreen!
    let payload: AnyObject?
    
    init(target: TargetScreen, payload: AnyObject? = nil) {
        self.target = target
        self.payload = payload
    }
}
