//
//  URLRequest+Addition.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

extension URLRequest {
    public var method: HTTPMethod? {
        get {
            if let httpMethod = httpMethod {
                return HTTPMethod(rawValue: httpMethod)
            } else {
                return nil
            }
        } set(newMethod) {
            httpMethod = newMethod?.rawValue
        }
    }
}
