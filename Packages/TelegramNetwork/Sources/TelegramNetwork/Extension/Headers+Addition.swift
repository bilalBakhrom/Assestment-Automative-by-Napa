//
//  Headers+Addition.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

extension Headers {
    public static var defaultHeaders: Headers {
        return [
            "Content-Type" : "application/json",
            "Connection" : "keep-alive"
        ]
    }
}
