//
//  UserSetting.swift
//  Wubi
//
//  Created by sakuragi on 2024/3/18.
//

import Foundation
import SwiftData

enum WubiScheme: String, Codable,Hashable {
    case wubi86 
    case wubi98
    case wubigbk
}

@Model
class UserSetting {
    
    var wubiScheme: WubiScheme
    var isShow86: Bool = true
    var isShow98: Bool = true
    var isShowgbk: Bool = true

    init(wubiScheme: WubiScheme = .wubi98) {
        self.wubiScheme = wubiScheme
    }
}
