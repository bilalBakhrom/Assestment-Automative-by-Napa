//
//  File.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

public enum WTimeRouter: RequestConvertible {
    case timezone
    
    public var environment: Environment {
        return .wtime
    }
    
    public var path: String {
        switch self {
        case .timezone:
            return "/timezone/Europe/Moscow"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
