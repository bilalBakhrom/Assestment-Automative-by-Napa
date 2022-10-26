//
//  AdaptableNetwork.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation
import SwiftSignalKit

public class AdaptableNetwork<SomeRouter: RequestConvertible>: Network {
    public typealias Router = SomeRouter
    public typealias ServiceCompletion<C: Codable> = (Result<C, NError>) -> Void
    public let session: URLSession
    private var disposables: [Disposable] = []
    
    public init(session: URLSession = .defaultSession) {
        self.session = session
    }
    
    deinit {
        disposables.forEach { $0.dispose() }
    }
    
    public func bind<T: Codable>(router: SomeRouter, completion: @escaping ServiceCompletion<T>) {
        let disposable = request(T.self, from: router)
            .start { time in
                completion(.success(time))
            } error: { error in
                completion(.failure(.unknown(error: error)))
            }
        
        disposables.append(disposable)
    }
}
