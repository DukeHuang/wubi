//
//  SettingItem.swift
//  Wubi
//
//  Created by yongyou on 2024/3/22.
//

import Foundation
import SwiftUI

enum SettingItem: String, Identifiable, CaseIterable {
    
    case wubiVersion
    case showWubiVersion
    case typing

    var id: UUID { UUID() }

    var icon: String {
        switch self {
            case .wubiVersion:
                "list.dash.header.rectangle"
            case .showWubiVersion:
                "books.vertical"
            case .typing:
                "keyboard"
        }
    }

    var name: String {
        switch self {
            case .wubiVersion:
                "跟打显示版本"
            case .showWubiVersion:
                "搜索显示版本"
            case .typing:
                "跟打相关设置"
        }
    }
    
    var backgroundColor: Color {
        switch self {
            case .wubiVersion:
                .gray
            case .showWubiVersion:
                .gray
            case .typing:
                .gray
        }
    }
}
