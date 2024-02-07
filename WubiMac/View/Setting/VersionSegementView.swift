//
//  VersionSegementView.swift
//  WubiMac
//
//  Created by sakuragi on 2024/2/6.
//

import SwiftUI

struct VersionSegementView: View {
    
    @State var version: Int
    var body: some View {
        Picker("", selection: $version) {
                        Text("86五笔").tag(0)
                        Text("98五笔").tag(1)
                        Text("新世纪五笔").tag(2)
                    }
                    .pickerStyle(.segmented)
    }
}

#Preview {
    VersionSegementView(version: 0)
}
