//
//  Call.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation

public enum CallType: String, Codable {
    case incoming
    case outgoing
    
    public enum IncomingCallStatus: String, Codable {
        case accepted
        case rejected
        case missed
    }
}

public enum CallConnection: String, Codable {
    case audio
    case video
}

public struct Call: Identifiable, Codable {
    public var id: Int
    public var date: String
    public var connection: CallConnection
    public var type: CallType
    public var incomingStatus: CallType.IncomingCallStatus?
    public var duration: Int?
    public var user: User
    
    enum CodingKeys: String, CodingKey {
        case id, date, connection, type, duration, user
        case incomingStatus = "incoming_status"
    }
    
    public var hasMissed: Bool {
        guard let incomingStatus = incomingStatus, type == .incoming else {
            return false
        }
        
        switch incomingStatus {
        case .accepted:
            return false
        case .rejected, .missed:
            return true
        }
    }
}

extension Call: Equatable {
    public static func ==(_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
