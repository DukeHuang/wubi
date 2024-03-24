//
//  VersionListView.swift
//  WubiMac
//
//  Created by yongyou on 2024/3/22.
//

import SwiftUI
import SwiftData

struct VersionListView: View {
    @State var isOn86: Bool = false
    @State var isOn98: Bool = false
    @State var isOngbk: Bool = false
    var userSetting: UserSetting?
    @Environment(\.modelContext) var modelContext

    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $isOn86) {
                Text("86五笔")
            }
            .toggleStyle(.checkbox)
            Toggle(isOn: $isOn98) {
                Text("98五笔")
            }
            .toggleStyle(.checkbox)
            Toggle(isOn: $isOngbk) {
                Text("新世纪五笔")
            }
            .toggleStyle(.checkbox)
        }
        .onChange(of: isOn86) { oldValue, newValue in
            userSetting?.isShow86 = newValue
        }
        .onChange(of: isOn98) { oldValue, newValue in
            userSetting?.isShow98 = newValue
        }
        .onChange(of: isOngbk) { oldValue, newValue in
            userSetting?.isShowgbk = newValue
        }
        .onAppear {
            isOn86 = userSetting?.isShow86 ?? false
            isOn98 = userSetting?.isShow98 ?? false
            isOngbk = userSetting?.isShowgbk ?? false
        }
    }
}

#Preview {
    VersionListView()
}
