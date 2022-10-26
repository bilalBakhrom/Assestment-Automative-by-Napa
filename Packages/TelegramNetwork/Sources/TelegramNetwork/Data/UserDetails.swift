//
//  UserDetails.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation

public enum UserDetailType: Int, Codable {
    case mobile = 0, username, bio
}

public struct UserDetails: Codable {
    public var items: [Content]
    
    public struct Content: Codable {
        public let type: UserDetailType
        public var title: String?
        public var data: String?
    }
}
