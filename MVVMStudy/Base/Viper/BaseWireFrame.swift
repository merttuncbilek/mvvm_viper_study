//
//  BaseWireFrame.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 17.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

class BaseWireFrame {
    
    static func getStoryBoard(with name: String) -> UIStoryboard {
        return UIStoryboard.init(name: name, bundle: Bundle.main)
    }
    
}
