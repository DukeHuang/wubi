//
//  SettingItem.swift
//  WubiMac
//
//  Created by yongyou on 2024/3/22.
//

import Foundation

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
                "五笔版本"
            case .showWubiVersion:
                "显示版本"
            case .typing:
                "跟打设置"
        }
    }
}
