//
//  CallService.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation

final public class CallService: AdaptableNetwork<CallRouter> {
    public override init(session: URLSession = URLSession.shared) {
        let fakeSession = URLSession(fakeResponder: Call.FakeDataURLResponder.self)
        super.init(session: fakeSession)
    }
    
    public func fetchCallList(completion: @escaping ServiceCompletion<[Call]>) {
        bind(router: .callList, completion: completion)
    }
}
