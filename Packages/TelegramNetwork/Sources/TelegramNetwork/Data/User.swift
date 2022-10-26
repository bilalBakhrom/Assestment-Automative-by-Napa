//
//  User.swift
//  
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

public struct User: Identifiable, Codable {
    public var id: String
    public var firstName: String
    public var lastName: String?
    public var profileImageURL: String?
    
    internal enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImageURL = "profile_image_url"
    }
}

extension User: Equatable {
    public static func ==(_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
