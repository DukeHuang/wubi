//
//  UserSetting.swift
//  WubiMac
//
//  Created by sakuragi on 2024/3/18.
//

import Foundation
import SwiftData

enum WubiScheme: Codable,Hashable {
    case wubi86 
    case wubi98
    case wubigbk
}

@Model
class UserSetting {
    
    let wubiScheme: WubiScheme

    init(wubiScheme: WubiScheme = .wubi98) {
        self.wubiScheme = wubiScheme
    }
}
