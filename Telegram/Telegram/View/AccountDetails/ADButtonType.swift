//
//  ADButtonType.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit

enum ADButtonType: Int, CaseIterable {
    case message = 0
    case call
    case video
    case mute
    case more
    
    var iconName: String {
        switch self {
        case .message: return "icon.action.message"
        case .call: return "icon.action.call"
        case .video: return "icon.action.video"
        case .mute: return "icon.action.bell"
        case .more: return "icon.action.more"
        }
    }
    
    var title: String {
        switch self {
        case .message: return "message"
        case .call: return "call"
        case .video: return "video"
        case .mute: return "mute"
        case .more: return "more"
        }
    }
}
