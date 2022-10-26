//
//  UserDetail.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

public enum UserDetailType: Int, CaseIterable {
    case mobile = 0
    case username
    case bio
}

public struct UserDetail {
    public var type: UserDetailType
    public var name: String
    public var data: String
}
