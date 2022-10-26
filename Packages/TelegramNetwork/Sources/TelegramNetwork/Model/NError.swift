//
//  NError.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

public enum NError: Error {
    case badId(code: Int)
    case urlFailed(reason: String)
    case responseFailed(reason: URLResponse)
    case unknown(error: Error)
}
