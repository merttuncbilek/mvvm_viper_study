//
//  MockProductResponse.swift
//  MVVMStudyTests
//
//  Created by Mert Tuncbilek on 18.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation

class MockProductResponse {
    
    static func createProductResponse() -> ProductsResponse {
        return ProductsResponse.init(JSONString:
        #"""
        {
        "products" : [
           {
           "product_id" : "11",
           "name" : "Bacon",
           "price" : 212,
           "image" : "https://s3-eu-west-1.amazonaws.com/developer-application-test/images/11.jpg"
            }
        ]
        }
        """#
            )!
    }
    
}
