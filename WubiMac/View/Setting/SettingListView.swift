//
//  SettingListView.swift
//  WubiMac
//
//  Created by sakuragi on 2024/2/6.
//

import SwiftUI

struct SettingListView: View {
    var body: some View {
        List {
            SideBarLabel(title: "五笔版本", imageName: "list.dash.header.rectangle")
            SideBarLabel(title: "显示版本", imageName: "books.vertical")
            SideBarLabel(title: "跟打", imageName: "keyboard")
        }
    }
}

#Preview {
    SettingListView()
}
