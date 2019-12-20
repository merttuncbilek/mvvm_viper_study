//
//  PostsResponse.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 12.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProductsResponse: Mappable {
    var products: [Product]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.products <- map["products"]
    }
}

struct Product: Mappable {
    
    var product_id: String?
    var price: Int?
    var name: String?
    var image: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.product_id <- map["product_id"]
        self.price <- map["price"]
        self.name <- map["name"]
        self.image <- map["image"]
    }
    
}
