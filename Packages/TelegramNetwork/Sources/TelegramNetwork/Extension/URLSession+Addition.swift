//
//  URLSession+Addition.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation

extension URLSession {
    public static var fakeCallSession: URLSession {
        return URLSession(fakeResponder: Call.FakeDataURLResponder.self)
    }
    
    public static var defaultSession: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }
}
