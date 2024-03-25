//
//  SettingListView.swift
//  Wubi
//
//  Created by sakuragi on 2024/2/6.
//

import SwiftUI

struct SettingSideBarLabel: View {
    var item: SettingItem

    var body: some View {
        HStack {
            Image(systemName:item.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all,4)
                .foregroundColor(.white)
                .background(item.backgroundColor)
                .frame(maxWidth: 20,maxHeight: 20)
                .cornerRadius(5.0)
            Spacer().frame(width: 15)
            Text(item.name)
        }
    }
}

struct SettingListView: View {
    @Binding var selected: SettingItem?
    var settingItems: [SettingItem]
    var body: some View {
        List(settingItems,id:\.self, selection: $selected) { item in
            SettingSideBarLabel(item: item)
        }.onAppear {
            selected = settingItems.first
        }
    }
}

#Preview {
    SettingListView(selected: .constant(SettingItem.showWubiVersion), settingItems: [.showWubiVersion,.typing,.wubiVersion])
}
