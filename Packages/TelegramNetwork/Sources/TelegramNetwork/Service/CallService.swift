//
//  CallService.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

final public class CallService: AdaptableNetwork<CallRouter> {
    public override init(session: URLSession = .fakeCallSession) {
        super.init(session: session)
    }
    
    public func fetchCallList(completion: @escaping ServiceCompletion<[Call]>) {
        bind(router: .callList, completion: completion)
    }
}
