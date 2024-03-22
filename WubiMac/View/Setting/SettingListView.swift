//
//  SettingListView.swift
//  WubiMac
//
//  Created by sakuragi on 2024/2/6.
//

import SwiftUI

struct SettingListView: View {
    @Binding var selected: SettingItem?
    var settingItems: [SettingItem]
    var body: some View {
        List(settingItems,id:\.self, selection: $selected) { item in
            HStack {
                SideBarLabel(title: item.name, imageName: item.icon)
            }
        }.onAppear {
            selected = settingItems.first
        }
    }
}

#Preview {
    SettingListView(selected: .constant(SettingItem.showWubiVersion), settingItems: [.showWubiVersion,.typing,.wubiVersion])
}
