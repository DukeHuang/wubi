//
//  VersionListView.swift
//  WubiMac
//
//  Created by yongyou on 2024/3/22.
//

import SwiftUI

struct VersionListView: View {
    @State var isOn86: Bool = false
    @State var isOn98: Bool = false
    @State var isOngbk: Bool = false

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
    }
}

#Preview {
    VersionListView()
}
