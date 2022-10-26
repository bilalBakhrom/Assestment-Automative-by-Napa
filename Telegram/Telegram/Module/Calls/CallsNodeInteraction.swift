//
//  CallsNodeInteraction.swift
//  Telegram
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import Foundation
import TelegramNetwork

final class CallsNodeInteraction {
    let openInfo: (Call) -> Void
    
    init(openInfo: @escaping (Call) -> Void) {
        self.openInfo = openInfo
    }
}
