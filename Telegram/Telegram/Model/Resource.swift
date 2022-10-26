//
//  Resource.swift
//  Telegram
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation
import SwiftSignalKit

public enum Resource<T: Codable> {
    case loading
    case failure(Error)
    case success(T)
    case none
}

extension Resource {
    public var loading: Bool {
        if case .loading = self {
            return true
        }
        
        return false
    }
    
    public var error: Error? {
        switch self {
        case .failure(let error):
            return error
            
        default:
            return nil
        }
    }
    
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
}
