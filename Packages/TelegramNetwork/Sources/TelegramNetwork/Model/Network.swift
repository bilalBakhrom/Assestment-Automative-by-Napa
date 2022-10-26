//
//  Network.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation
import SwiftSignalKit

protocol Network {
    associatedtype Router: RequestConvertible
    var session: URLSession { get }
}

extension Network {
    func request<T: Decodable>(_ type: T.Type, from router: Router) -> Signal<T, Error> {
        guard let request = router.urlRequest() else {
            fatalError()
        }

        return Signal { subscriber in
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    subscriber.putError(error)
                } else if let data = data, let response = response {
                    #if DEBUG
                    NLog.log(request: request, response: response, data: data)
                    #endif

                    do {
                        let data = try checkResponse(data: data, response: response)
                        let model = try JSONDecoder().decode(T.self, from: data)
                        subscriber.putNext(model)
                    } catch {
                        subscriber.putError(error)
                    }
                }

                subscriber.putCompletion()
            }
            task.resume()

            return EmptyDisposable
        }
    }

    private func checkResponse(data: Data, response: URLResponse) throws -> Data {
        guard let response = response as? HTTPURLResponse else {
            throw NError.responseFailed(reason: response)
        }

        if response.statusCode >= 200 && response.statusCode <= 300 {
            return data
        } else {
            throw NError.badId(code: response.statusCode)
        }
    }
}
