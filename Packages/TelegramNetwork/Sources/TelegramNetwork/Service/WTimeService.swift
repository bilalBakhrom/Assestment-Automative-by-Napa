//
//  WTimeService.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

final public class WTimeService: AdaptableNetwork<WTimeRouter> {
    public func fetchCurrentTime(completion: @escaping ServiceCompletion<WTime>) {
        bind(router: .timezone, completion: completion)
    }
}
