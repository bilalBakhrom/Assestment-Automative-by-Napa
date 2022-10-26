//
//  CallRouter.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

public enum CallRouter: RequestConvertible {
    case callList
    
    public var environment: Environment {
        return .telegram
    }
    
    public var path: String {
        switch self {
        case .callList:
            return "/calls"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
