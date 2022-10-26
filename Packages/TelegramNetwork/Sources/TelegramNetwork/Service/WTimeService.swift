//
//  WTimeService.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

final public class WTimeService: AdaptableNetwork<WTimeRouter> {
    public override init(session: URLSession = URLSession.shared) {
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        super.init(session: session)
    }
    
    public func fetchCurrentTime(completion: @escaping ServiceCompletion<WTime>) {
        bind(router: .timezone, completion: completion)
    }
}
