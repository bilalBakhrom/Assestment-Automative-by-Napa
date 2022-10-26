//
//  WTime+Responder.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation
@testable import TelegramNetwork

extension WTime {
    enum MockDataURLResponder: MockURLResponder {
        static let item: WTime = {
            WTime(abbreviation: "CDT", datetime: "2022-09-19T02:05:39.291601-05:00", timezone: "America/Chicago")
        }()

        static func respond(to request: URLRequest) throws -> Data {
            return try JSONEncoder().encode(item)
        }
    }
}
