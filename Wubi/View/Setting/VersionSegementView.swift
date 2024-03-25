//
//  VersionSegementView.swift
//  Wubi
//
//  Created by sakuragi on 2024/2/6.
//

import SwiftUI
import SwiftData
struct VersionSegementView: View {
    @State var version: Int
    @Query var userSettings: [UserSetting]
    var body: some View {


        #if os(macOS)
        Picker("", selection: $version) {
            Text("86五笔").tag(0)
            Text("98五笔").tag(1)
            Text("新世纪五笔").tag(2)
        }
        .pickerStyle(.radioGroup)
        .onChange(of: version) { oldValue, newValue in
            if newValue == 0 {
                userSettings.first?.wubiScheme = .wubi86
            } else if newValue == 1 {
                userSettings.first?.wubiScheme = .wubi98
            } else if newValue == 2 {
                userSettings.first?.wubiScheme = .wubigbk
            }
        }
        .onAppear {
            switch userSettings.first?.wubiScheme {
                case .some(.wubi86):
                    version = 0
                case .none:
                    version = 1
                case .some(.wubi98):
                    version = 1
                case .some(.wubigbk):
                    version = 2
            }
        }

        #else
        Picker("", selection: $version) {
            Text("86五笔").tag(0)
            Text("98五笔").tag(1)
            Text("新世纪五笔").tag(2)
        }
        .pickerStyle(.menu)
        .onChange(of: version) { oldValue, newValue in
            if newValue == 0 {
                userSettings.first?.wubiScheme = .wubi86
            } else if newValue == 1 {
                userSettings.first?.wubiScheme = .wubi98
            } else if newValue == 2 {
                userSettings.first?.wubiScheme = .wubigbk
            }
        }
        .onAppear {
            switch userSettings.first?.wubiScheme {
                case .some(.wubi86):
                    version = 0
                case .none:
                    version = 1
                case .some(.wubi98):
                    version = 1
                case .some(.wubigbk):
                    version = 2
            }
        }

        #endif

    }
}

#Preview {
    VersionSegementView(version: 0)
}
