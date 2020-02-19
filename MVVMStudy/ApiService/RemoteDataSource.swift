//
//  RemoteDataSource.swift
//  MVVMStudy
//
//  Created by Mert TUNÇBİLEK on 18.12.2019.
//  Copyright © 2019 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RemoteDataSource {
    
    static let shared = RemoteDataSource.init(baseURL: Constants.BaseURL)
    
    private let baseURL: String
    
    private init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func getFromApi<T: BaseMappable>(_ dump: T.Type, method: String, onResponse: @escaping ((Result<T, DataSourceError>) -> Void)) {
        AF.request(baseURL.appending(method), method: .get).responseString{ response in
            guard let json = response.value else {
                onResponse(.failure(.nilResponse))
                return
            }
            print(#"Response \#(json)"#)
            if let responseData = Mapper<T>().map(JSONString: json) {
                onResponse(.success(responseData))
            } else {
                onResponse(.failure(.businessError))
            }
            
        }
    }
    
}
