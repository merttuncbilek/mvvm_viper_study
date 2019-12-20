//
//  ProductDetail.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 20.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProductDetail: Mappable {
    var id: String?
    var name: String?
    var price: Int?
    var image: String?
    var description: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.id <- map["product_id"]
        self.name <- map["name"]
        self.price <- map["price"]
        self.image <- map["image"]
        self.description <- map["description"]
    }
}
