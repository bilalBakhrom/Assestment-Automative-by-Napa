//
//  CallSegment.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

enum CallSegment: Int, CaseIterable {
    case all = 0
    case missed
    
    var title: String {
        switch self {
        case .all: return "All"
        case .missed: return "Missed"
        }
    }
}
