//
//  RequestConvertible.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

public protocol RequestConvertible {
    var environment: Environment { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: Headers? { get }
    var parameters: Parameters? { get }
    
    func asURLRequest() throws -> URLRequest?
}

extension RequestConvertible {
    public var headers: Headers? {
        return .defaultHeaders
    }
    
    public var parameters: Parameters? {
        return nil
    }
    
    public func asURL() throws -> URL {
        let endPointString = environment.rawValue + path
        
        if let url = URL(string: endPointString) {
            return url
        } else  {
            throw NError.urlFailed(reason: "Couldn't create URL from \(endPointString)")
        }
    }
    
    public func urlRequest() -> URLRequest? {
        return try? asURLRequest()
    }
    
    public func asURLRequest() throws -> URLRequest? {
        let url = try asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.allHTTPHeaderFields = headers
        
        if let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(
                withJSONObject: parameters,
                options: .prettyPrinted
            )
        }
        
        return urlRequest
    }
}
