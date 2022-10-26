//
//  FakeURLProtocol.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation

internal protocol FakeURLResponder {
    static func respond(to request: URLRequest) throws -> Data
}

final internal class FakeURLProtocol<Responder: FakeURLResponder>: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let client = client else { return }

        do {
            let data = try Responder.respond(to: request)
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )!

            client.urlProtocol(self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
            client.urlProtocol(self, didLoad: data)
        } catch {
            client.urlProtocol(self, didFailWithError: error)
        }

        client.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // Required method, implement as a no-op.
    }
}

extension URLSession {
    convenience init<T: FakeURLResponder>(fakeResponder: T.Type) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [FakeURLProtocol<T>.self]
        self.init(configuration: config)
        URLProtocol.registerClass(FakeURLProtocol<T>.self)
    }
}
