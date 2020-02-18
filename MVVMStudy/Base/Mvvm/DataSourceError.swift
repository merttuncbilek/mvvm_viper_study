//
//  DataSourceError.swift
//  MVVMStudy
//
//  Created by Mert Tuncbilek on 18.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation

enum DataSourceError: Error {
    case nilResponse
    case badResponse
    case businessError
    
}
