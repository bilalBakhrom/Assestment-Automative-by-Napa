//
//  WService.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

final public class WService: AdaptableNetwork<WRouter> {
    public func fetchCurrentTime(completion: @escaping ServiceCompletion<WTime>) {
        bind(router: .timezone, completion: completion)
    }
}
